local M = {}
M.config = function()
    local api = vim.api
    api.nvim_command('source ~/.config/nvim/viml/defx.vim')
end

M.map = function()
    local map = require('utils').map
    map({'n', 'i'}, '<F1>',
        ":Defx -toggle -resume -winwidth=40 -direction=topleft -split=vertical -ignored-files=.*,*.d<cr>",
        {silent = true})
    map({'n'}, '<leader>j',
        ":Defx  -split=vertical -ignored-files=.*,*.d -winwidth=40 -direction=topleft `getcwd()` -search=`expand('%:p')`<cr>",
        {silent = true})
end

return M;
