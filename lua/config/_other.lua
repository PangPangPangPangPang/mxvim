local M = {}
M.textobj_setup = function()
	vim.defer_fn(function()
		vim.cmd([[ PackerLoad vim-textobj-user ]])
	end, 200)
end
M.signature_setup = function()
	vim.defer_fn(function()
		vim.cmd([[ PackerLoad vim-signature ]])
	end, 200)
end
M.colorizer_setup = function()
	vim.defer_fn(function()
		vim.cmd([[ PackerLoad nvim-colorizer.lua ]])
	end, 200)
end
M.copilot_setup = function()
	-- vim.defer_fn(function()
	-- 	vim.cmd([[
        -- inoremap <silent><expr> <C-j> copilot#Accept("")
        -- let g:copilot_no_tab_map = 1
        -- PackerLoad copilot.vim ]])
	-- end, 200)
end
return M
