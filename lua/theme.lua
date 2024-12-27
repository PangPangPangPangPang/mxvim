local M = {}
M.theme = function(name, nick)
	local ret = {
		name,
		enabled = mxvim.current_theme == nick,
		config = function()
			require("colorscheme." .. mxvim.current_theme).config()
			require("config._tree").theme()
			if mxvim.style == "pure" then
				require("config._lualine_pure")
			elseif mxvim.style == "simple" then
				require("config._lualine_simple")
			else
				require("config._lualine")
			end
			M.hl_common()
			local shade_colors = require("theme").colors(0.6)
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
	local lighter = require("theme").colors(0.2)
	local darker = require("theme").colors(0.4)
	local colors = require("theme").colors()
	vim.api.nvim_set_hl(0, "Visual", { fg = "none", bg = darker.blue })
	vim.api.nvim_set_hl(0, "CursorLine", { fg = "none", bg = lighter.blue })
	vim.api.nvim_set_hl(0, "Search", { fg = "none", bg = darker.magenta })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.magenta, bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { link = "cleared" })
	vim.api.nvim_set_hl(0, "MsgArea", { link = "cleared" })
	vim.api.nvim_set_hl(0, "MatchParen", { underline = true, fg = colors.cyan })
	vim.api.nvim_set_hl(0, "Greenbg", { fg = "none", bg = colors.green })
	vim.api.nvim_set_hl(0, "Blackfg", { fg = colors.bg, bg = "none" })
	vim.api.nvim_set_hl(0, "Redfg", { fg = colors.red, bg = "none" })
	vim.api.nvim_set_hl(0, "RedfgBold", { fg = colors.red, bg = "none", bold = true })
	vim.api.nvim_set_hl(0, "Yellowfg", { fg = colors.yellow, bg = "none" })
	vim.api.nvim_set_hl(0, "Bluefg", { fg = colors.blue, bg = "none" })
	vim.api.nvim_set_hl(0, "Orangefg", { fg = colors.orange, bg = "none" })
	vim.api.nvim_set_hl(0, "Greenfg", { fg = colors.green, bg = "none" })
	vim.api.nvim_set_hl(0, "Purplefg", { fg = colors.purple, bg = "none" })
	vim.api.nvim_set_hl(0, "Cyanfg", { fg = colors.cyan, bg = "none" })
	-- vim.api.nvim_set_hl(0, "LineNr", { fg = "bg", bg = "none" })
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

-- alpha >= 0 && alpha < 1
M.shade = function(color, alpha, full)
	local bg = full and "#000000" or require("colorscheme." .. mxvim.current_theme).colors().bg
	if mxvim.background == "light" then
		bg = full and "#FFFFFF" or require("colorscheme." .. mxvim.current_theme).colors().fg
	end
	return require("utils").blend(color, bg, alpha)
end

M.theme_colors = function()
	local colors = require("colorscheme." .. mxvim.current_theme).colors()
	if mxvim.background == "light" then
		local ret = require("utils").shallow_copy(colors)
		ret.fg = colors.bg
		ret.bg = colors.fg
		return ret
	end
	return colors
end

if mxvim.style == "simple" then
	M.lsp_icon = {
		error = "⏺︎ ",
		warn = "⏺︎ ",
		hint = "⏺︎ ",
		info = "⏺︎ ",
	}
	M.border = "rounded"
else
	M.lsp_icon = {
		error = " ",
		warn = " ",
		hint = " ",
		info = " ",
	}
	M.border = "rounded"
end

return M