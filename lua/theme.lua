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
			vim.cmd([[
                hi! link NormalFloat cleared
            ]])
			local colors = require("theme").theme_colors()
			local shade_colors = require("theme").shade_colors(0.4)
			vim.cmd(string.format("hi! CmpItemAbbrMatch gui=bold guifg=%s", colors.blue))
			vim.cmd(string.format("hi! CmpItemAbbrMatchFuzzy gui=bold guifg=%s", colors.blue))
			vim.cmd(string.format("hi! CmpItemMenu gui=bold guifg=%s", shade_colors.fg))
			vim.cmd(string.format("hi! markdownBoldItalic gui=bold,italic guifg=%s", colors.blue))
			vim.cmd(string.format("hi! Cursor gui=bold guibg=%s guifg=%s", colors.fg, colors.bg))

			local bg = "bg"
			local fg = "fg"
			local hi = "NONE"

			vim.cmd(string.format("highlight! CmpItemKindField gui%s=%s gui%s=%s", bg, hi, fg, colors.yellow))
			vim.cmd(string.format("highlight! CmpItemKindProperty gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
			vim.cmd(string.format("highlight! CmpItemKindEvent gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))
			vim.cmd(string.format("highlight! CmpItemKindText gui%s=%s gui%s=%s", bg, hi, fg, colors.magenta))
			vim.cmd(string.format("highlight! CmpItemKindEnum gui%s=%s gui%s=%s", bg, hi, fg, colors.red))
			vim.cmd(string.format("highlight! CmpItemKindKeyword gui%s=%s gui%s=%s", bg, hi, fg, colors.green))
			vim.cmd(string.format("highlight! CmpItemKindConstant gui%s=%s gui%s=%s", bg, hi, fg, colors.yellow))
			vim.cmd(string.format("highlight! CmpItemKindConstructor gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
			vim.cmd(string.format("highlight! CmpItemKindReference gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))
			vim.cmd(string.format("highlight! CmpItemKindFunction gui%s=%s gui%s=%s", bg, hi, fg, colors.magenta))
			vim.cmd(string.format("highlight! CmpItemKindStruct gui%s=%s gui%s=%s", bg, hi, fg, colors.red))
			vim.cmd(string.format("highlight! CmpItemKindClass gui%s=%s gui%s=%s", bg, hi, fg, colors.green))
			vim.cmd(string.format("highlight! CmpItemKindModule gui%s=%s gui%s=%s", bg, hi, fg, colors.yellow))
			vim.cmd(string.format("highlight! CmpItemKindOperator gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
			vim.cmd(string.format("highlight! CmpItemKindVariable gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))
			vim.cmd(string.format("highlight! CmpItemKindFile gui%s=%s gui%s=%s", bg, hi, fg, colors.magenta))
			vim.cmd(string.format("highlight! CmpItemKindUnit gui%s=%s gui%s=%s", bg, hi, fg, colors.red))
			vim.cmd(string.format("highlight! CmpItemKindSnippet gui%s=%s gui%s=%s", bg, hi, fg, colors.green))
			vim.cmd(string.format("highlight! CmpItemKindFolder gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
			vim.cmd(string.format("highlight! CmpItemKindMethod gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))
			vim.cmd(string.format("highlight! CmpItemKindValue gui%s=%s gui%s=%s", bg, hi, fg, colors.magenta))
			vim.cmd(string.format("highlight! CmpItemKindEnumMember gui%s=%s gui%s=%s", bg, hi, fg, colors.red))
			vim.cmd(string.format("highlight! CmpItemKindInterface gui%s=%s gui%s=%s", bg, hi, fg, colors.green))
			vim.cmd(string.format("highlight! CmpItemKindColor gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
			vim.cmd(string.format("highlight! CmpItemKindTypeParameter gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))

			-- vim.cmd(string.format("hi! PmenuSel guifg=none"))
			vim.cmd(string.format("hi! MatchParen cterm=reverse gui=underline"))

			vim.cmd(string.format("hi! TelescopePromptTitle gui=bold guifg=%s", colors.red))
			vim.cmd(string.format("hi! TelescopePreviewTitle gui=bold guifg=%s", colors.green))
			vim.cmd(string.format("hi! TelescopeResultsTitle gui=bold guifg=%s", colors.blue))
			vim.cmd(string.format("hi! TelescopeSelection guifg=%s guibg=%s", colors.bg, colors.green))
			vim.cmd(string.format("hi! TelescopeMatching gui=bold guifg=%s", colors.red))
			vim.cmd([[
            hi! link FloatBorder Normal
            " hi! StatusLineNC guibg=none
            " hi! StatusLine guibg=none
            ]])
			local shade_default_colors = require('theme').shade_colors_default()
			vim.cmd(string.format("hi! DiffViewDiffAdd guibg=%s guifg=none", shade_default_colors.green))
			vim.cmd(string.format("hi! DiffViewDiffDelete guibg=%s guifg=none", shade_default_colors.red))
			vim.cmd(string.format("hi! DiffText guibg=%s guifg=none", shade_colors.green))
			vim.cmd(string.format("hi! DiffChange guibg=%s guifg=none", shade_default_colors.green))
		end,
	}
	if nick ~= nil then
		ret["name"] = nick
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
		local bg_r = tonumber(string.sub(colors.fg, 2, 3), 16)
		local bg_g = tonumber(string.sub(colors.fg, 4, 5), 16)
		local bg_b = tonumber(string.sub(colors.fg, 6, 7), 16)
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
	if color == nil then
		return
	end
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
		local shade_color = '#FFFFFF'
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