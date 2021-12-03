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
M.dd_setup = function()
	vim.defer_fn(function()
		vim.cmd([[ PackerLoad nvim-dd.git ]])
	end, 400)
end
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

M.setup_lightspeed = function ()
	vim.defer_fn(function()
		vim.cmd([[
            PackerLoad lightspeed.nvim
            silent! unmap s
            silent! unmap S
            nmap cl <Plug>Lightspeed_s
            nmap cc <Plug>Lightspeed_S
        ]])
	end, 400)
end
return M
