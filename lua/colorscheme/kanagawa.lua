local M = {}
M.setup = function()
	vim.cmd([[ PackerLoad kanagawa.nvim]])
	vim.opt.fillchars:append({
		horiz = "━",
		horizup = "┻",
		horizdown = "┳",
		vert = "┃",
		vertleft = "┨",
		vertright = "┣",
		verthoriz = "╋",
	})
end
M.config = function()
	local default_colors = require("kanagawa.colors").setup()
	require("kanagawa").setup({
		undercurl = true, -- enable undercurls
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		variablebuiltinStyle = { italic = true },
		specialReturn = true, -- special highlight for the return keyword
		specialException = true, -- special highlight for exception handling keywords
		transparent = false, -- do not set background color
		dimInactive = false, -- dim inactive window `:h hl-NormalNC`
		globalStatus = false, -- adjust window separators highlight for laststatus=3
		colors = {},
		overrides = {
			VertSplit = { fg = "#D27E99", bg = "NONE" },
		},
	})
	vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
	return {
		fg = "#DCD7BA",
		bg = "#16161D",
		light_fb = "#717C7C",
		light_bg = "#1F1F28",
		fg_green = "#76946A",
		yellow = "#E6C384",
		cyan = "#7AA89F",
		darkblue = "#658594",
		green = "#98BB6C",
		orange = "#FFA066",
		purple = "#957FB8",
		magenta = "#D27E99",
		blue = "#7E9CD8",
		red = "#FF5D62",
	}
end
return M
