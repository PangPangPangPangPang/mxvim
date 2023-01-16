local M = {}
M.setup_hop = function ()
	vim.defer_fn(function()
		vim.cmd([[ PackerLoad hop.nvim ]])
        local map = require("utils").dmap
        map({'n', 'x'}, 'cl', ':HopWord<cr>')
	end, 400)
end
M.copilot_setup = function()
	vim.defer_fn(function()
		vim.cmd([[
        inoremap <silent><expr> <C-j> copilot#Accept("")
        let g:copilot_no_tab_map = 1
        PackerLoad copilot.vim ]])
	end, 200)
end
return M
