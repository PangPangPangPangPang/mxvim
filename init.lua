_G.mxvim = {}

-- nightfly github-theme miramare vscode nord onedarkpro rose-pine catppuccin gruvbox-material gruvbox-baby kanagawa nightfox tundra oh-lucy oh-lucy-evening
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
mxvim.enable_lspsage = true
mxvim.compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua"

require("basic")
require("plugins")
