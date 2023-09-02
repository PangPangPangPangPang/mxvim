local M = {}
M.config = function()
    local api = vim.api
    api.nvim_command('source ~/.config/nvim/viml/defx.vim')
end

M.map = function()
    local dmap = require('utils').dmap
    dmap({'n', 'i'}, '<F1>',
        ":Defx -toggle -resume -winwidth=40 -direction=topleft -split=vertical -ignored-files=.*,*.d<cr>",
        "Open file tree")
    dmap({'n'}, '<leader>j',
        ":Defx  -split=vertical -ignored-files=.*,*.d -winwidth=40 -direction=topleft `getcwd()` -search=`expand('%:p')`<cr>",
        "Open file tree")
end

return M;