local M = {}
M.setup = function ()
    vim.g.ZFVimIM_keymap = 0

end
M.config = function ()
    local map = require('utils').map
    local opts = {noremap = true, silent = true, expr = true}
    map('i', ';;', 'ZFVimIME_keymap_toggle_i()', opts)
    M.setLocalDB();
end

M.setLocalDB = function ()
    local db = vim.fn.ZFVimIM_dbInit({name = 'MaxDB'})
    vim.fn.ZFVimIM_cloudRegister({mode = 'local', dbId = db['dbId'], repoPath = '~/.config/nvim', dbFile = '/pinyin.txt'})
end
return M
