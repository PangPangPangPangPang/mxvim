require('basic')

local fn = vim.fn
local cmd = vim.cmd
local uv = vim.loop
local conf_dir = fn.stdpath('config')
if uv.fs_stat(conf_dir .. '/plugin/packer_compiled.lua') then
    cmd([[
    com! PackerInstall lua require('plugs.packer').install()
    com! PackerUpdate lua require('plugs.packer').update()
    com! PackerSync lua require('plugs.packer').sync()
    com! PackerClean lua require('plugs.packer').clean()
    com! PackerStatus lua require('plugs.packer').status()
    com! -nargs=? PackerCompile lua require('plugs.packer').compile(<q-args>)
    com! -nargs=+ PackerLoad lua require('plugs.packer').loader(<q-args>)
    ]])
else
    require('packer').compile()
end
require('plugins')
