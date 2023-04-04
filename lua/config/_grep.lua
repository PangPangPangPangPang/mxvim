local M = {}

M.setup = function()
    vim.g.grepper = {
        simple_propt = 0,
        tools = { 'rg', 'ag', 'ack', 'grep', 'findstr', 'pt', 'git' },
        rg = {
            grepprg = "rg -H --no-heading --ignore-case -g '!{*build*,*release*,*gecko*}' --vimgrep",
            grepformat = '%f:%l:%c:%m',
            escape = "^$.*+?()[]{}|"
        },
        pt = {
            grepprg = 'pt --nocolor --nogroup',
            grepformat = '%f:%l:%m',
            escape = '+*^$()[]'
        },
        highlight = 1
    }
    local dmap = require('utils').dmap
    dmap({'x'}, '<leader>f', ':<c-u>silent call GrepperOperator(visualmode())<cr>')


end

return M
