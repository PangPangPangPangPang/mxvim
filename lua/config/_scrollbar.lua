local M = {}
local colors = require("theme").shade_colors(0.8)
M.setup = function()
	vim.defer_fn(function()
        vim.cmd(string.format("highlight! ScrollBarHighlight guibg=%s guifg=NONE", colors.fg_green))
		vim.cmd([[
            PackerLoad nvim-scrollbar
        ]])
	end, 1000)
end
M.config = function()
	require("scrollbar").setup({
		show = true,
		set_highlights = true,
		handle = {
			text = " ",
			color = nil,
			cterm = nil,
			highlight = "ScrollBarHighlight",
			hide_if_all_visible = true, -- Hides handle if all lines are visible
		},
		marks = {
			Search = {
				text = { "-", "=" },
				priority = 0,
				color = nil,
				cterm = nil,
				highlight = "Search",
			},
			Error = {
				text = { "-", "=" },
				priority = 1,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticSignError",
			},
			Warn = {
				text = { "-", "=" },
				priority = 2,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticSignWarn",
			},
			Info = {
				text = { "-", "=" },
				priority = 3,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticSignInfo",
			},
			Hint = {
				text = { "-", "=" },
				priority = 4,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticSignHint",
			},
			Misc = {
				text = { "-", "=" },
				priority = 5,
				color = nil,
				cterm = nil,
				highlight = "Normal",
			},
		},
		excluded_buftypes = {
			"terminal",
		},
		excluded_filetypes = {
			"prompt",
			"TelescopePrompt",
            "NvimTree"
		},
		autocmd = {
			render = {
				"BufWinEnter",
				"TabEnter",
				"TermEnter",
				"WinEnter",
				"CmdwinLeave",
				"TextChanged",
				"VimResized",
				"WinScrolled",
			},
		},
		handlers = {
			diagnostic = true,
			search = false, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
		},
	})
end
return M
