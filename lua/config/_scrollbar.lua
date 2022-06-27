local M = {}
-- local colors = require("theme").shade_colors(0.8)
M.setup = function()
	vim.defer_fn(function()
		vim.cmd([[
            PackerLoad satellite.nvim
        ]])
	end, 1000)
end
M.config = function()
	require("satellite").setup({
		current_only = false,
		winblend = 50,
		zindex = 40,
		excluded_filetypes = {},
		width = 2,
		handlers = {
			search = {
				enable = true,
			},
			diagnostic = {
				enable = true,
			},
			gitsigns = {
				enable = true,
			},
			marks = {
				enable = true,
				show_builtins = false, -- shows the builtin marks like [ ] < >
			},
		},
	})
end
return M
