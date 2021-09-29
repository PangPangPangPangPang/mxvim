_G.mxvim = {}

-- nightfly github-theme miramare vscode nord
mxvim.current_theme = 'vscode'
mxvim.use_coc = false
mxvim.use_treesitter = true
mxvim.background = 'dark'
mxvim.shade_percent = 0.4

require('basic')
require('plugins')

local conf_dir = vim.fn.stdpath('config')
if vim.uv.fs_stat(conf_dir .. '/plugin/packer_compiled.lua') then
    vim.cmd([[
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
