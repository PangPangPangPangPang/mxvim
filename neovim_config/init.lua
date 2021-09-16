require('basic')
require('plugins')

local fn = vim.fn
local cmd = vim.cmd
local uv = vim.loop
local conf_dir = fn.stdpath('config')
if uv.fs_stat(conf_dir .. '/plugin/packer_compiled.lua') then
    cmd([[
    com! PackerInstall lua require('packer').install()
    com! PackerUpdate lua require('packer').update()
    com! PackerSync lua require('packer').sync()
    com! PackerClean lua require('packer').clean()
    com! PackerStatus lua require('packer').status()
    com! -nargs=? PackerCompile lua require('packer').compile(<q-args>)
    com! -nargs=+ PackerLoad lua require('packer').loader(<q-args>)
    ]])
else
    require('packer').compile()
end
