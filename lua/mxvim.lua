_G.mxvim = {}

-- nightfly github-theme miramare vscode nord onedarkpro rose-pine catppuccin
-- gruvbox-material gruvbox-baby kanagawa nightfox tundra oh-lucy oh-lucy-evening
-- melange monokai tokyonight-day oxocarbon bamboo
mxvim.current_theme = "kanagawa"
-- light / dark
mxvim.background = "dark"
-- simple / pure / normal
mxvim.style = "simple"
mxvim.use_coc = false
mxvim.use_cmp = true
mxvim.use_notify = false
mxvim.enable_lspsaga = true
mxvim.enable_neotree = false
mxvim.enable_statuscol = true

-- map q to quick close
mxvim.ignore_list = { "qf", "fugitive", "git", "Trouble", "noice", "fugitiveblame", "NeogitStatus", "help" }

mxvim.treesitter_filetype = { "markdown", "javascript", "javascriptreact", "lua" }
mxvim.enable_treesitter = true
mxvim.enable_codeium = true
mxvim.enable_action_preview = false
mxvim.show_fold = false
mxvim.enable_cursor = true
mxvim.enable_ts_tools = true
mxvim.enable_squirrel = true