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
            silent! nunmap s
            silent! nunmap S
            nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
            nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
            nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
            nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"
            nmap cl <Plug>Lightspeed_s
            nmap cc <Plug>Lightspeed_S
        ]])
        local colors = require("theme").theme_colors()
        vim.cmd(string.format("hi! LightspeedOneCharMatch gui=bold guibg=%s", colors.red))
        vim.cmd(string.format("hi! LightspeedShortcut gui=bold guibg=%s", colors.red))
        vim.cmd(string.format("hi! LightspeedLabel gui=bold guifg=%s", colors.red))
        vim.cmd(string.format("hi! LightspeedLabelOverlapped guifg=%s", colors.red))
	end, 400)
end
return M
