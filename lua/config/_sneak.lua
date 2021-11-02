local M = {}
M.setup = function()
    vim.defer_fn(function ()
        vim.cmd([[
            let g:sneak#label = 1
            nmap f <Plug>Sneak_f
            nmap F <Plug>Sneak_F
            nmap t <Plug>Sneak_t
            nmap T <Plug>Sneak_T
            " nmap cl <Plug>Sneak_s
            " nmap cc <Plug>Sneak_S
            xmap f <Plug>Sneak_f
            xmap F <Plug>Sneak_F
            xmap t <Plug>Sneak_t
            xmap T <Plug>Sneak_T
            " xmap cl <Plug>Sneak_s
            " xmap cc <Plug>Sneak_S
            PackerLoad vim-sneak
        ]])
    end, 1000)
end
M.config = function ()
    local colors = require('theme').theme_colors()
    vim.api.nvim_exec(string.format([[
        autocmd User SneakEnter highlight Sneak guifg=%s guibg=%s ctermfg=black ctermbg=red
        autocmd User SneakEnter highlight SneakScope guifg=%s guibg=%s ctermfg=red ctermbg=yellow
    ]], colors.bg, colors.red, colors.red, colors.yellow), false)
end
return M
