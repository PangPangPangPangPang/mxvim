_G.mxvim = {}

-- nightfly github-theme miramare vscode nord onedarkpro rose-pine catppuccin gruvbox-material kanagawa
mxvim.current_theme = "kanagawa"
-- galaxy lualine
mxvim.current_line = "lualine"
mxvim.use_coc = false
mxvim.use_treesitter = true
mxvim.background = "dark"
mxvim.shade_percent = 0.7
mxvim.use_cmp = true
mxvim.use_coq = false
mxvim.use_notify = true
mxvim.compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua"

require("basic")
require("plugins")

if vim.loop.fs_stat(mxvim.compile_path) then
	vim.cmd([[
    com! PackerInstall lua require('packer').install()
    com! PackerUpdate lua require('packer').update()
    com! PackerSync lua require('packer').sync()
    com! PS lua require('packer').sync()
    com! PackerClean lua require('packer').clean()
    com! PackerStatus lua require('packer').status()
    com! -nargs=? PackerCompile lua require('packer').compile(<q-args>)
    com! -nargs=? PC lua require('packer').compile(<q-args>)
    com! -nargs=+ PackerLoad lua require('packer').loader(<q-args>)
    " ]])
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		pattern = "plugins.lua",
		callback = function()
			vim.cmd([[
            source <afile> | PackerCompile
            ]])
		end,
	})
end
