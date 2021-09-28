local fn = vim.fn
local g = vim.g

local map = require('utils').map
pcall(require, 'impatient')

vim.g.did_load_filetypes = 1

-- Automatically install packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd 'packadd packer.nvim'
end

require('packer').startup({
    function(use)
        -- Packer itself
        use {'wbthomason/packer.nvim', opt = true}
        use {'lewis6991/impatient.nvim'}
        use{ 'nathom/filetype.nvim' }


        use {'nvim-lua/popup.nvim'}
        use {'nvim-lua/plenary.nvim'}

        use {
            require('theme').theme('Mofiqul/vscode.nvim'),
            require('theme').theme('projekt0n/github-nvim-theme'),
            require('theme').theme('bluz71/vim-nightfly-guicolors'),
            require('theme').theme('PangPangPangPangPang/miramare'),
            require('theme').theme('shaunsingh/nord.nvim'),
        }

        use {
            'NTBBloodbath/galaxyline.nvim',
            branch = 'main',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
        }
        use {
            "ZSaberLv0/ZFVimIM",
            opt = true,
            requires = {
                "ZSaberLv0/ZFVimJob", "ZSaberLv0/ZFVimGitUtil",
                "PangPangPangPangPang/ZFVimIM_pinyin",
                "ZSaberLv0/ZFVimIM_openapi"
            },
            setup = function() require('config._zfvimim').setup() end,
            config = function() require('config._zfvimim').config() end
        }

        -- Readline style insertion
        use {'tpope/vim-rsi'}

        use {'kevinhwang91/nvim-bqf', ft = 'qf', branch = 'main'}

        -- commenter
        use {
            'tpope/vim-commentary',
            config = function ()
                vim.g.kommentary_create_default_mappings = false
                vim.api.nvim_set_keymap("n", "<leader>/", "gcc", {})
                vim.api.nvim_set_keymap("v", "<leader>/", "gc", {})
            end
        }

        if mxvim.use_treesitter then
            use {
                'nvim-treesitter/nvim-treesitter',
                requires = {
                    'nvim-treesitter/nvim-treesitter-textobjects',
                    'p00f/nvim-ts-rainbow',
                    'windwp/nvim-ts-autotag',
                    'JoosepAlviste/nvim-ts-context-commentstring',
                },
                run = ':TSUpdate',
                config = function() require('config._treesitter') end
            }
        else
            use {'sheerun/vim-polyglot'}
            use {'luochen1990/rainbow'}
            g.rainbow_active = 1
        end

        use {
            'lukas-reineke/indent-blankline.nvim',
            event = "VimEnter",
            config = function() require('config._indentline').setup() end
        }

        use {'tpope/vim-surround'}

        use {
            'mhinz/vim-grepper',
            fn = {'GrepperOperator'},
            cmd = {'GrepperRg', 'Grepper'},
            setup = function() require('config._grep').setup() end
        }

        if mxvim.use_coc == true then
            use {
                'neoclide/coc.nvim',
                branch = 'release',
                config = function()
                    require('config._coc').config()
                end
            }

            use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
            use {'honza/vim-snippets'}
            use {
                'sbdchd/neoformat',
                cmd = 'Neoformat',
                setup = function() require('config._neoformat').config() end
            }
        else
            -- nvim builtin lsp
            use {
                "neovim/nvim-lspconfig",
                opt = true,
                requires = {'kabouzeid/nvim-lspinstall'},
                setup = function()
                    require("config._lsp_config").setup()
                end,
                config = function()
                    require("config._lsp_config").config()
                end
            }
            use {
                "jose-elias-alvarez/null-ls.nvim",
                opt = true,
                requires = {"neovim/nvim-lspconfig"},
                setup = function()
                    require("lsp.lsp_nullls").setup();
                end,
                config = function()
                    require("lsp.lsp_nullls").config();
                end
            }
            use {
                "hrsh7th/nvim-cmp",
                opt = true,
                disable = false,
                requires = {
                    "onsails/lspkind-nvim",
                    "hrsh7th/cmp-nvim-lua",
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-path",
                    "hrsh7th/cmp-buffer",
                    {
                        "hrsh7th/cmp-vsnip",
                        wants = "friendly-snippets",
                        requires = {
                            'hrsh7th/vim-vsnip-integ',
                            "hrsh7th/vim-vsnip",
                            "rafamadriz/friendly-snippets"
                        }
                    }
                },
                setup = function()
                    require("config._nvim_cmp").setup()
                end,
                config = function()
                    require("config._nvim_cmp").config()
                end
            }

            use {
                "windwp/nvim-autopairs",
                after = "nvim-cmp",
                config = function ()
                    require("config._autopairs").setup()
                end
            }

            use {
                'ms-jpq/coq_nvim',
                disable = true,
                branch = 'coq',
                setup = function() require("config._coq").config() end
            } -- main one
            use {'ms-jpq/coq.artifacts', branch = 'artifacts'} -- 9000+ Snippets

            use {
                "ray-x/lsp_signature.nvim",
                opt = true,
                config = function()
                    require("config._lsp_config").signature()
                end
            }

            use {
                "norcalli/nvim-colorizer.lua",
                opt = true,
                setup = function() require('config._other').colorizer_setup() end,
                config = function() require'colorizer'.setup() end
            }

            use {
                "simrat39/symbols-outline.nvim",
                cmd = {"SymbolsOutline"},
                setup = function()
                    require('config._outline').config();
                end
            }
        end

        use {'tweekmonster/startuptime.vim', cmd = {'StartupTime'}}

        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
            },
            cmd = {'Telescope'},
            config = function() require('config._telescope').config() end,
            setup = function() require('config._telescope').map() end
        }

        use {
            'iamcco/markdown-preview.nvim',
            run = 'cd app && yarn install',
            cmd = {'MarkdownPreview'}
        }

        use {
            'voldikss/vim-floaterm',
            cmd = {'FloatermToggle', 'FloatermNew'},
            setup = function() require('config._vim_floaterm').map() end
        }

        use {
            'szw/vim-maximizer',
            cmd = {'MaximizerToggle'},
            setup = function ()
                local lmap = require('utils').map
                lmap('n', '<c-w>z', ':MaximizerToggle<CR>', {silent = true})
                lmap('v', '<c-w>z', ':MaximizerToggle<CR>gv', {silent = true})
            end
        }

        g.CoolTotalMatches = 1
        use {'romainl/vim-cool'}

        g.smoothie_base_speed = 20
        use {
            'psliwka/vim-smoothie',
        }

        use {
            'lewis6991/gitsigns.nvim',
            opt = true,
            setup = function() require('config._gitsigns').setup() end,
            config = function() require('config._gitsigns').config() end
        }
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            opt = true,
            -- cmd = {'NvimTreeToggle', 'NvimTreeFindFile'},
            config = function() require('config._tree').config() end,
            setup = function ()
                require('config._tree').setup()
            end
        }

        use {
            'tpope/vim-fugitive',
            opt = true,
            setup = function() require('config._fugitive').setup() end,
        }
        use {'rbong/vim-flog'}
        use {'rhysd/git-messenger.vim'}

        use {
            'justinmk/vim-sneak',
            opt = true,
            setup = function() require('config._sneak').setup() end,
            config = function() require('config._sneak').config() end
        }
        use {
            'kshenoy/vim-signature',
            opt = true,
            setup = function() require('config._other').signature_setup() end,
        }

        use {'simnalamburt/vim-mundo', cmd = {'MundoToggle'}}
        map('n', '<F6>', ':MundoToggle<CR>', {silent = true})

        -- html
        use {
            'mattn/emmet-vim',
            ft = {'css', 'javascriptreact', 'html', 'typescriptreact'}
        }
        g.user_emmet_expandabbr_key = '<C-y><tab>'
        g.user_emmet_prev_key = '<C-y>p'

        use {'tpope/vim-dadbod', cmd = {'DB'}}
        use {'skywind3000/vim-quickui'}
        g.quickui_border_style = 2
        g.quickui_color_scheme = 'system'

        -- use {
        --     'kana/vim-textobj-user',
        --     opt = true,
        --     requires = {
        --         {'kana/vim-textobj-function', opt = true},
        --         {'kana/vim-textobj-indent', opt = true},
        --         {'kana/vim-textobj-line', opt = true}
        --     },
        --     setup = function()
        --         require("config._other").textobj_setup()
        --     end
        -- }
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({border = 'single'})
            end
        }
    }
})
