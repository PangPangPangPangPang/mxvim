local M = {}
M.setup = function()
    vim.defer_fn(function ()
        vim.cmd([[ 
            map f <Plug>Sneak_f
            map F <Plug>Sneak_F
            map t <Plug>Sneak_t
            map T <Plug>Sneak_T
            map cl <Plug>Sneak_s
            map cc <Plug>Sneak_S
            PackerLoad vim-sneak 
        ]])
    end, 1000)
end
M.config = function ()
    local colors = require('colorscheme.' .. mxvim.current_theme).colors()
    vim.api.nvim_exec(string.format([[
        autocmd User SneakEnter highlight Sneak guifg=%s guibg=%s ctermfg=black ctermbg=red
        autocmd User SneakEnter highlight SneakScope guifg=%s guibg=%s ctermfg=red ctermbg=yellow
    ]], colors.bg, colors.red, colors.red, colors.yellow), false)
end
return M
