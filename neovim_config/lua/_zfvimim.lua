local M = {}
M.setup = function ()
    vim.api.nvim_del_keymap('i', ';;');
    local map = require('utils').map
    local opts = {noremap = true, silent = true, expr = true}
    map('i', '<c-i>', 'ZFVimIME_keymap_toggle_i()', opts)
    M.setLocalDB();
end

M.setLocalDB = function ()
    -- local db = vim.api.nvim_call_function('ZFVimIM_dbInit', {name = 'MaxDB'})
    local db = vim.fn.ZFVimIM_dbInit({name = 'MaxDB'})
    vim.fn.ZFVimIM_cloudRegister({mode = 'local', dbId = db['dbId'], repoPath = '~/.config/nvim', dbFile = '/pinyin.txt'})
end
return M
