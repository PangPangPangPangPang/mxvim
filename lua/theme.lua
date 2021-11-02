mxvim.init_theme = false
local M = {}
M.theme = function(name)
	return {
		name,
		opt = true,
		setup = function()
			if mxvim.init_theme == false then
				require("colorscheme." .. mxvim.current_theme).setup()
				mxvim.init_theme = true
			end
		end,
		config = function()
			require("colorscheme." .. mxvim.current_theme).config()
			require("config._tree").theme()
			require("config._galaxyline")
			vim.cmd([[
                hi! link NormalFloat cleared
            ]])
            local colors = require('theme').theme_colors()
            vim.cmd(string.format('hi CmpItemAbbrMatch gui=bold guifg=%s', colors.yellow))
            vim.cmd(string.format('hi CmpItemMenu gui=bold guifg=%s', colors.cyan))
            vim.cmd(string.format('hi CmpItemKind gui=bold guifg=%s', colors.blue))
		end,
	}
end

M.extract_nvim_hl = function(name)
  local hl_str = vim.api.nvim_exec('highlight ' .. name, true)
  return {
    fg = hl_str:match('guifg=(#[0-9A-Fa-f]+)') or '#444444',
    bg = hl_str:match('guibg=(#[0-9A-Fa-f]+)') or '#1E1E1E',
    style = hl_str:match('gui=(#[0-9A-Fa-f]+)') or '',
    name = name,
  }
end

-- color: #FFFFFF
-- percent >= 0 && percent < 1
M.shade = function(color, percent)
	if mxvim.background == "dark" then
		local r = string.format("%02x", tonumber(string.sub(color, 2, 3), 16) * percent)
		local g = string.format("%02x", tonumber(string.sub(color, 4, 5), 16) * percent)
		local b = string.format("%02x", tonumber(string.sub(color, 6, 7), 16) * percent)
		return string.format("#%s%s%s", r, g, b)
	else
		local r = string.format("%02x", 256 - (256 - tonumber(string.sub(color, 2, 3), 16)) * percent)
		local g = string.format("%02x", 256 - (256 - tonumber(string.sub(color, 4, 5), 16)) * percent)
		local b = string.format("%02x", 256 - (256 - tonumber(string.sub(color, 6, 7), 16)) * percent)
		return string.format("#%s%s%s", r, g, b)
	end
end

M.shade_default = function(color)
	return M.shade(color, mxvim.shade_percent)
end

M.theme_colors = function()
	local colors = require("colorscheme." .. mxvim.current_theme).colors()
	if mxvim.background == "light" then
		local ret = require("utils").shallow_copy(colors)
		ret.fg = colors.light_fg
		ret.bg = colors.light_bg
		return ret
	end
	return colors
end

M.shade_colors = function(percent)
	local colors = require("colorscheme." .. mxvim.current_theme).colors()
	local ret = require("utils").shallow_copy(colors)
	for index, _ in pairs(ret) do
		ret[index] = M.shade(colors[index], percent)
	end
	return ret
end

local static_shade_colors
M.shade_colors_default = function()
	if static_shade_colors ~= nil then
		return static_shade_colors
	end
	local colors = require("colorscheme." .. mxvim.current_theme).colors()
	static_shade_colors = require("utils").shallow_copy(colors)
	for index, _ in pairs(static_shade_colors) do
		static_shade_colors[index] = M.shade_default(colors[index])
	end
	return static_shade_colors
end
return M
