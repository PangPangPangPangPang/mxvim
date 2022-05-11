mxvim.init_theme = false
local M = {}
M.theme = function(name, nick)
	local ret = {
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
            if mxvim.current_line == "galaxy" then
                require("config._galaxyline")
            else
                require("config._lualine")
            end
			vim.cmd([[
                hi! link NormalFloat cleared
            ]])
			local colors = require("theme").theme_colors()
            local shade_colors = require("theme").shade_colors(0.4)
			vim.cmd(string.format("hi! CmpItemAbbrMatch gui=bold guifg=%s", colors.blue))
			vim.cmd(string.format("hi! CmpItemAbbrMatchFuzzy gui=bold guifg=%s", colors.blue))
			vim.cmd(string.format("hi! CmpItemMenu gui=bold guifg=%s", shade_colors.fg))
			vim.cmd(string.format("highlight! CmpItemKindVariable guibg=NONE guifg=%s", colors.yellow))
			vim.cmd(string.format("highlight! CmpItemKindInterface guibg=NONE guifg=%s", colors.orange))
			vim.cmd(string.format("highlight! CmpItemKindText guibg=NONE guifg=%s", colors.darkblue))
			vim.cmd(string.format("highlight! CmpItemKindFunction guibg=NONE guifg=%s", colors.magenta))
			vim.cmd(string.format("highlight! CmpItemKindMethod guibg=NONE guifg=%s", colors.red))
			vim.cmd(string.format("highlight! CmpItemKindKeyword guibg=NONE guifg=%s", colors.green))
			-- vim.cmd(string.format('hi! CmpItemKind gui=bold guifg=%s', colors.yellow))
			vim.cmd(string.format("hi! PmenuSel guifg=none"))
			vim.cmd(string.format("hi! MatchParen cterm=reverse gui=underline"))
		end,
	}
	if nick ~= nil then
		ret["as"] = nick
	end
	return ret
end

M.extract_nvim_hl = function(name)
	local hl_str = vim.api.nvim_exec("highlight " .. name, true)
	return {
		fg = hl_str:match("guifg=(#[0-9A-Fa-f]+)") or "#444444",
		bg = hl_str:match("guibg=(#[0-9A-Fa-f]+)") or "#1E1E1E",
		style = hl_str:match("gui=(#[0-9A-Fa-f]+)") or "",
		name = name,
	}
end

-- color: #FFFFFF
-- percent >= 0 && percent < 1
M.shade = function(color, percent)
	if mxvim.background == "dark" then
		local colors = require("colorscheme." .. mxvim.current_theme).colors()
		local bg_r = tonumber(string.sub(colors.bg, 2, 3), 16)
		local bg_g = tonumber(string.sub(colors.bg, 4, 5), 16)
		local bg_b = tonumber(string.sub(colors.bg, 6, 7), 16)
		local cur_r = tonumber(string.sub(color, 2, 3), 16)
		local cur_g = tonumber(string.sub(color, 4, 5), 16)
		local cur_b = tonumber(string.sub(color, 6, 7), 16)
		local r = string.format("%02x", cur_r - (cur_r - bg_r) * percent)
		local g = string.format("%02x", cur_g - (cur_g - bg_g) * percent)
		local b = string.format("%02x", cur_b - (cur_b - bg_b) * percent)
		return string.format("#%s%s%s", r, g, b)
	else
		local colors = require("colorscheme." .. mxvim.current_theme).colors()
		local bg_r = tonumber(string.sub(colors.bg, 2, 3), 16)
		local bg_g = tonumber(string.sub(colors.bg, 4, 5), 16)
		local bg_b = tonumber(string.sub(colors.bg, 6, 7), 16)
		local cur_r = tonumber(string.sub(color, 2, 3), 16)
		local cur_g = tonumber(string.sub(color, 4, 5), 16)
		local cur_b = tonumber(string.sub(color, 6, 7), 16)
		local r = string.format("%02x", cur_r + (bg_r - cur_r) * percent)
		local g = string.format("%02x", cur_g + (bg_g - cur_g) * percent)
		local b = string.format("%02x", cur_b + (bg_b - cur_b) * percent)
		return string.format("#%s%s%s", r, g, b)
	end
end

M.shade_all = function(color, percent)
	if mxvim.background == "dark" then
		local shade_color = '#000000'
		local bg_r = tonumber(string.sub(shade_color, 2, 3), 16)
		local bg_g = tonumber(string.sub(shade_color, 4, 5), 16)
		local bg_b = tonumber(string.sub(shade_color, 6, 7), 16)
		local cur_r = tonumber(string.sub(color, 2, 3), 16)
		local cur_g = tonumber(string.sub(color, 4, 5), 16)
		local cur_b = tonumber(string.sub(color, 6, 7), 16)
		local r = string.format("%02x", cur_r - (cur_r - bg_r) * percent)
		local g = string.format("%02x", cur_g - (cur_g - bg_g) * percent)
		local b = string.format("%02x", cur_b - (cur_b - bg_b) * percent)
		return string.format("#%s%s%s", r, g, b)
	else
		-- local colors = require("colorscheme." .. mxvim.current_theme).colors()
		local shade_color = '#FFFFFF'
		-- local shade_color = colors.light_bg
		local bg_r = tonumber(string.sub(shade_color, 2, 3), 16)
		local bg_g = tonumber(string.sub(shade_color, 4, 5), 16)
		local bg_b = tonumber(string.sub(shade_color, 6, 7), 16)
		local cur_r = tonumber(string.sub(color, 2, 3), 16)
		local cur_g = tonumber(string.sub(color, 4, 5), 16)
		local cur_b = tonumber(string.sub(color, 6, 7), 16)
		local r = string.format("%02x", cur_r + (bg_r - cur_r) * percent)
		local g = string.format("%02x", cur_g + (bg_g - cur_g) * percent)
		local b = string.format("%02x", cur_b + (bg_b - cur_b) * percent)
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
