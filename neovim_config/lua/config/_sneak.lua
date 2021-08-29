local M = {}
M.setup = function ()
    -- local map = require('utils').map
    -- local opts = {noremap = true, silent = true}
    -- map("n", "f", "<Plug>Sneak_f", opts)
    -- map("n", "F", "<Plug>Sneak_F", opts)
    -- map("n", "t", "<Plug>Sneak_t", opts)
    -- map("n", "T", "<Plug>Sneak_T", opts)
    -- map("n", "cl", "<Plug>Sneak_s", opts)
    -- map("n", "cc", "<Plug>Sneak_S", opts)
    vim.api.nvim_exec([[
        map f <Plug>Sneak_f
        map F <Plug>Sneak_F
        map t <Plug>Sneak_t
        map T <Plug>Sneak_T
        map cl <Plug>Sneak_s
        map cc <Plug>Sneak_S
        highlight Sneak guifg=#222222 guibg=#F44747 ctermfg=black ctermbg=red
        highlight SneakScope guifg=#F44747 guibg=#DCDCAA ctermfg=red ctermbg=yellow
    ]], false)
end
return M
