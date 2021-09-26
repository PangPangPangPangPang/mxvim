local M = {}
M.map = function()
    local g = vim.g
    local map = require('utils').map
    vim.api.nvim_command('hi! link FloatermBorder Directory')
    g.floaterm_title = '$1/$2'
    map('n', '<F5>', ":FloatermToggle default<CR>", {silent = true})
    map('t', '<F5>', "<C-\\><C-n>:FloatermToggle default<CR>", {silent = true})
    map('t', '<esc>', "<C-\\><C-n>:FloatermKill<CR>", {silent = true})
    map('n', '<leader>lg', ":FloatermNew --width=0.8 --height=0.8 lazygit<CR>",
        {silent = true})
end

return M
