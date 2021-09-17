local M = {}
M.setup = function ()
    local colors = require('colorscheme.' .. vim.g.current_theme).colors()
    vim.api.nvim_exec(string.format([[
        map f <Plug>Sneak_f
        map F <Plug>Sneak_F
        map t <Plug>Sneak_t
        map T <Plug>Sneak_T
        map cl <Plug>Sneak_s
        map cc <Plug>Sneak_S
        highlight Sneak guifg=%s guibg=%s ctermfg=black ctermbg=red
        highlight SneakScope guifg=%s guibg=%s ctermfg=red ctermbg=yellow
    ]], colors.bg, colors.red, colors.red, colors.yellow), false)
end
return M
