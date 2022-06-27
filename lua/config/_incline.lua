local M = {}
-- local colors = require("theme").shade_colors(0.8)
M.setup = function()
	vim.defer_fn(function()
		vim.cmd([[
            PackerLoad incline.nvim
        ]])
	end, 100)
end
M.config = function()
	require("incline").setup({
		debounce_threshold = {
			falling = 50,
			rising = 10,
		},
		hide = {
			cursorline = false,
			focused_win = false,
			only_win = false,
		},
		highlight = {
			groups = {
				InclineNormal = {
					default = true,
					group = "NormalFloat",
				},
				InclineNormalNC = {
					default = true,
					group = "NormalFloat",
				},
			},
		},
		ignore = {
			buftypes = "special",
			filetypes = {},
			floating_wins = true,
			unlisted_buffers = true,
			wintypes = "special",
		},
		render = "basic",
		window = {
			margin = {
				horizontal = 1,
				vertical = 1,
			},
			options = {
				signcolumn = "no",
				wrap = true,
			},
			padding = 1,
			padding_char = " ",
			placement = {
				horizontal = "right",
				vertical = "top",
			},
			width = "fit",
			winhighlight = {
				active = {
					EndOfBuffer = "None",
					Normal = "Label",
					Search = "Search",
				},
				inactive = {
					EndOfBuffer = "None",
					Normal = "NonText",
					Search = "None",
				},
			},
			zindex = 50,
		},
	})
end
return M
