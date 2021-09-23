---@diagnostic disable: lowercase-global, undefined-global
local M = {}
M.setup = function ()
    vim.g.ZFVimIM_keymap = 0
    vim.cmd([[
        let g:ZFVimIM_symbolMap = {'`' : ['·'],'!' : ['！'],'$' : ['￥'],'^' : ['……'],'-' : [''],'_' : ['——'],'(' : ['（'],')' : ['）'],'[' : ['【'],']' : ['】'],'<' : ['《'],'>' : ['》'],'\' : ['、'],'/' : ['、'],';' : ['；'],':' : ['：'],',' : ['，'],'.' : ['。'],'?' : ['？'],"'" : ['‘', '’'],'"' : ['“', '”'],}
    ]])
    if vim.o.filetype == 'markdown' then
        vim.cmd([[ PackerLoad ZFVimIM ]])
    end
    local map = require('utils').map
    local opts = {noremap = true, silent = true}
    map('i', ';;', "<C-o>:lua toggle_zfvimim()<cr>", opts)
end
function toggle_zfvimim()
    if packer_plugins["ZFVimIM"] and packer_plugins["ZFVimIM"].loaded then
    else
        vim.cmd([[ PackerLoad ZFVimIM ]])
    end
    vim.fn.ZFVimIME_keymap_toggle_i();
end
M.config = function ()
    M.setLocalDB();
end


M.setLocalDB = function ()
    local fn = vim.fn
    if require('utils').is_module_available('private') == true then
        local db = fn.ZFVimIM_dbInit({name = 'MaxDB'})
        vim.fn.ZFVimIM_cloudRegister({mode = 'local', dbId = db['dbId'], repoPath = '~/.config/nvim', dbFile = '/pinyin.txt'})
    end
end
return M
