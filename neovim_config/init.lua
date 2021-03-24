local g = vim.g
local fn = vim.fn
local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo
local api = vim.api
g.mapleader = ' '

vim.api.nvim_command('source ~/.config/nvim/basic.vim')

require('plugins')

local files =fn.split(fn.glob('~/.config/nvim/plugin_config/*.vim'))
for _, v in pairs(files) do
        vim.api.nvim_command('source '..v)
end
