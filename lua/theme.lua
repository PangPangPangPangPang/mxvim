local M = {}
M.theme = function(name, nick)
	local ret = {
		name,
		enabled = mxvim.current_theme == nick,
		config = function()
			require("colorscheme." .. mxvim.current_theme).config()
			require("config._tree").theme()
			if mxvim.current_line == "galaxy" then
				require("config._galaxyline")
			else
				require("config._lualine_pure")
			end

			M.hl_common()
			local shade_colors = require("theme").colors(0.4)
			require("config._nvim_cmp").hl_cmp(shade_colors)
			require("config._telescope").hl_telescope()
			require("config._fzf").hl_fzf()
			require("config._diffview").hl_diff(shade_colors)
		end,
	}
	if nick ~= nil then
		ret["name"] = nick
	end
	return ret
end

M.hl_common = function()
	local lighter = require('theme').colors(0.8)
	local darker = require('theme').colors(0.6)
	local colors = require("theme").colors()
	vim.api.nvim_set_hl(0, "Visual", { fg = "none", bg = darker.blue })
	vim.api.nvim_set_hl(0, "CursorLine", { fg = "none", bg = lighter.blue })
	vim.api.nvim_set_hl(0, "Search", { fg = "none", bg = darker.magenta })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.magenta, bg = "none" })
	vim.cmd([[ hi! link NormalFloat cleared ]])
	vim.cmd(string.format("hi! MatchParen cterm=reverse gui=underline"))

	vim.api.nvim_set_hl(0, "Greenbg", { fg = "none", bg = colors.green })
	vim.api.nvim_set_hl(0, "Blackfg", { fg = colors.bg, bg = "none" })
	vim.api.nvim_set_hl(0, "Redfg", { fg = colors.red, bg = "none" })
end

local static_shade_colors = {}

M.colors = function(percent)
	if percent == nil then
		return M.theme_colors()
	end
	if static_shade_colors[percent] ~= nil then
		return static_shade_colors[percent]
	end
	local colors = require("colorscheme." .. mxvim.current_theme).colors()
	local shadow_colors = require("utils").shallow_copy(colors)
	for index, _ in pairs(shadow_colors) do
		shadow_colors[index] = M.shade(colors[index], percent)
	end
	static_shade_colors[percent] = shadow_colors
	return static_shade_colors[percent]
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

-- percent >= 0 && percent < 1
M.shade = function(color, percent, full)
	local shade_color
	if mxvim.background == "dark" then
		shade_color = full and "#000000" or require("colorscheme." .. mxvim.current_theme).colors().bg
		local colors = require("colorscheme." .. mxvim.current_theme).colors()
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
		shade_color = full and "#FFFFFF" or require("colorscheme." .. mxvim.current_theme).colors().fg
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

return M