local fn = vim.fn
local g = vim.g

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.cmd [[ com! PS lua require('lazy').sync() ]]


require("lazy").setup({
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },

    require("theme").theme("Mofiqul/vscode.nvim", "vscode"),
    require("theme").theme("projekt0n/github-nvim-theme", "github-theme"),
    require("theme").theme("bluz71/vim-nightfly-guicolors", "nightfly"),
    require("theme").theme("PangPangPangPangPang/miramare", "miramare"),
    require("theme").theme("shaunsingh/nord.nvim", "nord"),
    require("theme").theme("olimorris/onedarkpro.nvim", "onedarkpro"),
    require("theme").theme("rose-pine/neovim", "rose-pine"),
    require("theme").theme("catppuccin/nvim", "catppuccin"),
    require("theme").theme("sainnhe/gruvbox-material", "gruvbox-material"),
    require("theme").theme("rebelot/kanagawa.nvim", "kanagawa"),
    require("theme").theme("EdenEast/nightfox.nvim", "nightfox"),
    require("theme").theme("sam4llis/nvim-tundra", "tundra"),
    require("theme").theme("luisiacc/gruvbox-baby", "gruvbox-baby"),
    require("theme").theme("Yazeed1s/oh-lucy.nvim", "oh-lucy"),
    require("theme").theme("savq/melange-nvim", "melange"),
    require("theme").theme("AlexvZyl/nordic.nvim", "nordic"),
    require("theme").theme("loctvl842/monokai-pro.nvim", "monokai"),
    { "drmikehenry/vim-fixkey" },
    {
        "glepnir/galaxyline.nvim",
        enabled = mxvim.current_line == "galaxy",
        branch = "main",
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "bercly0b/lualine-lsp-progress",
        },
        enabled = mxvim.current_line == "lualine",
    },

    {
        "ZSaberLv0/ZFVimIM",
        lazy = true,
        keys = {
            { "<M-i>", "<cmd>lua toggle_zfvimim()<cr>", mode = "n" },
            { "<M-i>", "<c-o>:lua toggle_zfvimim()<cr>", mode = "i" },
        },
        dependencies = {
            "ZSaberLv0/ZFVimJob",
            "ZSaberLv0/ZFVimGitUtil",
            "PangPangPangPangPang/ZFVimIM_pinyin",
            "ZSaberLv0/ZFVimIM_openapi",
        },
        init = function()
            require("config._zfvimim").setup()
        end,
        config = function()
            require("config._zfvimim").config()
        end,
    },
    -- Readline style insertion
    { "tpope/vim-rsi" },

    { "kevinhwang91/nvim-bqf", ft = "qf", branch = "main" },

    -- commenter
    {
        "tpope/vim-commentary",
        config = function()
            vim.g.kommentary_create_default_mappings = false
            vim.api.nvim_set_keymap("n", "<leader>/", "gcc", {})
            vim.api.nvim_set_keymap("v", "<leader>/", "gc", {})
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "p00f/nvim-ts-rainbow",
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/playground",
            {
                "windwp/nvim-autopairs",
                config = function()
                    require("config._autopairs").setup()
                end,
            },
        },
        build = ":TSUpdate",
        config = function()
            require("config._treesitter")
        end,
    },

    {
        "m-demare/hlargs.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("config._treesitter").inithlargs()
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("config._indentline").setup()
        end,
    },

    { "tpope/vim-surround" },

    {
        "mhinz/vim-grepper",
        lazy = true,
        event = "VeryLazy",
        init = function()
            require("config._grep").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            { "williamboman/mason.nvim", lazy = true },
            { "nvim-lua/lsp-status.nvim", lazy = true },
            {
                "neovim/nvim-lspconfig",
                lazy = true,
                config = function()
                    require("config._lsp_config").config()
                end,
            },
        },
        config = function()
            require("config._mason").config()
        end,
    },
    {
        "j-hui/fidget.nvim",
        enabled = false,
        -- lazy = true,
        config = function()
            require("fidget").setup({})
        end,
    },
    {
        "https://gitlab.com/yorickpeterse/nvim-dd.git",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("dd").setup({
                timeout = 0,
            })
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        enabled = false,
        -- lazy = true,
        dependencies = { "neovim/nvim-lspconfig" },
        setup = function()
            require("lsp.lsp_nullls").setup()
        end,
        config = function()
            require("lsp.lsp_nullls").config()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            "onsails/lspkind-nvim",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            {
                "hrsh7th/cmp-vsnip",
                dependencies = {
                    "hrsh7th/vim-vsnip-integ",
                    "hrsh7th/vim-vsnip",
                    "rafamadriz/friendly-snippets",
                },
            },
            {
                "quangnguyen30192/cmp-nvim-tags",
                lazy = true,
                event = "VeryLazy",
                -- if you want the sources is available for some file types
                -- ft = {
                --     "javascriptreact",
                --     "typescriptreact",
                --     "javascript",
                --     "typescript",
                --     "lua",
                -- },
            },
        },
        config = function()
            require("config._nvim_cmp").config()
        end,
    },
    {
        "ms-jpq/coq_nvim",
        enabled = false,
        -- lazy = true,
        branch = "coq",
        dependencies = {
            { "ms-jpq/coq.artifacts", branch = "artifacts" },
        },
        config = function()
            require("config._coq").config()
        end,
    },

    {
        "glepnir/lspsaga.nvim",
        lazy = true,
        enabled = mxvim.enable_lspsage,
        event = "VeryLazy",
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
        config = function()
            require("config._lsp_saga").config()
        end,
    },
    {
        "folke/lsp-trouble.nvim",
        lazy = true,
        cmd = { "LspTrouble", "Trouble" },
        config = function()
            require("config._lsp_trouble").config()
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("colorizer").setup()
        end,
    },

    {
        "simrat39/symbols-outline.nvim",
        enabled = false,
        -- cmd = { "SymbolsOutline" },
    },
    {
        "karb94/neoscroll.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("config._neoscroll").config()
        end,
    },
    {
        "lewis6991/satellite.nvim",
        enabled = false,
        -- lazy = true,
        config = function()
            require("config._scrollbar").config()
        end,
    },

    -- debugger
    {
        "ravenxrz/nvim-dap",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            "ravenxrz/DAPInstall.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "nvim-telescope/telescope-dap.nvim",
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<c-p>", "<cmd>Telescope find_files<cr>" },
            { "<leader>f", "<cmd>Telescope live_grep<cr>", { "n" } },
        },
        config = function()
            require("config._telescope").config()
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        ft = { "markdown" },
    },

    {
        "voldikss/vim-floaterm",
        cmd = { "FloatermToggle", "FloatermNew" },
        keys = {
            { "<F5>", "<cmd>lua require('config._vim_floaterm').open_term()<cr>", mode = "n" },
            { "<F5>", "<C-\\><C-n>:lua require('config._vim_floaterm').open_term()<CR>", mode = "t" },
            { "<Esc>", "<C-\\><C-n>:lua require('config._vim_floaterm').close()<CR>", mode = "t" },
            { "<leader>lg", ":lua require('config._vim_floaterm').open_lazygit()<CR>", mode = "n" },
        },
        config = function()
            require("config._vim_floaterm").map()
        end,
    },

    {
        "RishabhRD/nvim-cheat.sh",
        lazy = true,
        config = function()
            vim.g.cheat_default_window_layout = "float"
        end,
        cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
        dependencies = {
            "RishabhRD/popfix",
        },
    },

    {
        "szw/vim-maximizer",
        cmd = { "MaximizerToggle" },
        init = function()
            local lmap = require("utils").map
            lmap("n", "<c-w>z", ":MaximizerToggle<CR>", { silent = true })
            lmap("v", "<c-w>z", ":MaximizerToggle<CR>gv", { silent = true })
        end,
    },

    { "romainl/vim-cool",
        init = function()
            g.CoolTotalMatches = 1
        end,
    },

    {
        "psliwka/vim-smoothie",
        enabled = false,
        init = function()
            g.smoothie_base_speed = 20
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("config._gitsigns").config()
        end,
    },
    {
        "kyazdani42/nvim-tree.lua",
        lazy = true,
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
        init = function()
            require("config._tree").init()
        end,
        keys = {
            { "<F1>", "<cmd>NvimTreeToggle<cr>", mode = "n" },
            { "<leader>j", "<cmd>NvimTreeFindFile<cr>", mode = { "n" } },
        },
        config = function()
            require("config._tree").config()
        end,
    },

    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewClose' },
        keys = {
            { "<F3>", "<cmd>lua require(\"utils\").toggleDiffView()<cr>", mode = "n" },
        },
        config = function()
            require("config._diffview").config()
        end,
    },

    {
        "tpope/vim-fugitive",
        lazy = true,
        event = "VeryLazy",
    },
    {
        "rhysd/git-messenger.vim",
        cmd = { "GitMessenger" },
    },

    {
        "ggandor/leap.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("config._leap").config()
        end,
    },

    {
        "chentoast/marks.nvim",
        enabled = false,
        lazy = true,
        config = function()
            require("config._mark").config()
        end,
    },

    {
        "justinmk/vim-sneak",
        enabled = false,
        lazy = true,
        config = function()
            require("config._sneak").config()
        end,
    },
    {
        "kshenoy/vim-signature",
        enabled = false,
        lazy = true,
    },

    { "simnalamburt/vim-mundo",
        cmd = { "MundoToggle" },
        keys = {
            { "<F7>", "<cmd>MundoToggle<cr>", mode = "n" },
        },
    },

    -- html
    {
        "mattn/emmet-vim",
        ft = { "css", "javascriptreact", "html", "typescriptreact" },
        init = function()
            g.user_emmet_expandabbr_key = "<C-y><tab>"
            g.user_emmet_prev_key = "<C-y>p"
        end
    },

    { "tpope/vim-dadbod", cmd = { "DB" } },
    { "skywind3000/vim-quickui",
        lazy = true,
        event = "VeryLazy",
        init = function()
            g.quickui_border_style = 2
            g.quickui_color_scheme = "system"
        end
    },

    {
        -- "~/bilibili_live_broadcast",
        "PangPangPangPangPang/bilibili_live_broadcast",
        lazy = true,
        cmd = { "BiliLive" },
        config = function()
            require("config._bili_live").config()
        end,
        dependencies = { "rcarriga/nvim-notify" },
    },

    {
        "PangPangPangPangPang/prettier-number-line.nvim",
        lazy = true,
        event = "VimEnter",
        config = function()
            -- current virtual
            require("prettier-number-line").setup({
                mode = "current",
                show_col = false,
                exclusive_filetype = { "fugitive" },
                col_highlight = "VertSplit",
            })
        end,
    },
    {
        "github/copilot.vim",
        enabled = false,
        lazy = true,
    },

    {
        "b0o/incline.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("config._incline").config()
        end,
    },
    { "ybian/smartim",
        lazy = true,
        -- event = { "InsertEnter" },
        config = function()
            -- default IME mode
            vim.g.smartim_default = "com.apple.keylayout.ABC"
        end
    },
})
