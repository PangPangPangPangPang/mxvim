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

			local colors = require("theme").colors()
			local shade_colors = require("theme").colors(0.4)
			M.hl_common(shade_colors)
			M.hl_cmp(shade_colors)
			M.hl_telescope()
			M.hl_diff(shade_colors)
			M.hl_fzf(shade_colors)
		end,
	}
	if nick ~= nil then
		ret["name"] = nick
	end
	return ret
end

M.hl_common = function(shade_colors)
	local lighter = require('theme').colors(0.8)
	local darker = require('theme').colors(0.6)
	local colors = require("theme").colors()
	vim.api.nvim_set_hl(0, "Visual", { fg = "none", bg = darker.blue })
	vim.api.nvim_set_hl(0, "CursorLine", { fg = "none", bg = lighter.blue })
	vim.api.nvim_set_hl(0, "Search", { fg = "none", bg = darker.magenta })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.magenta, bg = "none" })
	vim.cmd([[ hi! link NormalFloat cleared ]])
	vim.cmd(string.format("hi! MatchParen cterm=reverse gui=underline"))
end

M.hl_diff = function(shade_colors)
	local shade_default_colors = require('theme').colors(0.7)
	vim.cmd(string.format("hi! DiffAdd guibg=%s guifg=none", shade_default_colors.green))
	vim.cmd(string.format("hi! DiffDelete guibg=%s guifg=%s", shade_default_colors.red, shade_default_colors.bg))
	vim.cmd(string.format("hi! DiffText guibg=%s guifg=none", shade_colors.green))
	vim.cmd(string.format("hi! DiffChange guibg=%s guifg=none", shade_default_colors.green))
end

M.hl_telescope = function()
	local colors = require("theme").colors()
	vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bold = true, fg = colors.red })
	vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bold = true, fg = colors.green })
	vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bold = true, fg = colors.blue })
	vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = colors.bg, bg = colors.green })
	vim.api.nvim_set_hl(0, "TelescopeMatching", { bold = true, fg = colors.red })
end

M.hl_fzf = function(shade_colors)
	vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "Directory" })
	vim.api.nvim_set_hl(0, "FzfLuaTitle", { link = "Float" })
end

M.hl_cmp = function(shade_colors)
	local colors = require("theme").colors()
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