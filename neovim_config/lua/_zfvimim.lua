local M = {}
M.setup = function ()
    vim.api.nvim_del_keymap('i', ';;');
    local map = require('utils').map
    local opts = {noremap = true, silent = true, expr = true}
    map('i', '<c-i>', 'ZFVimIME_keymap_toggle_i()', opts)
    vim.api.nvim_exec([[
    function! s:myLocalDb()
    let db = ZFVimIM_dbInit({
        \   'name' : 'YourDb',
        \ })
        call ZFVimIM_cloudRegister({
            \   'mode' : 'local',
            \   'dbId' : db['dbId'],
            \   'repoPath' : '~/.config/nvim', 
            \   'dbFile' : '/pinyin.txt', 
            \ })
            endfunction
            " autocmd User ZFVimIM_event_OnDbInit call s:myLocalDb()

            ]], false)
        end
return M
