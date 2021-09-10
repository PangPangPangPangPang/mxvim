local fn = vim.fn
local cmd = vim.cmd
local g = vim.g

local map = require('utils').map
local opts = {noremap = true, silent = true}
pcall(require, 'impatient')

-- Automatically install packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

cmd [[packadd packer.nvim]]
require('packer').startup({
    function(use)
        -- Packer itself
        use {'wbthomason/packer.nvim', opt = true}
        use {'lewis6991/impatient.nvim'}

        -- nightfly github-theme miramare vscode nord
        vim.g.current_theme = 'nord'
        use {
            'Mofiqul/vscode.nvim',
            requires = {
                {'projekt0n/github-nvim-theme'},
                {'bluz71/vim-nightfly-guicolors'},
                {'PangPangPangPangPang/miramare'}, {'shaunsingh/nord.nvim'}
            },
            config = function()
                require('colorscheme.' .. vim.g.current_theme).config();
            end
        }

        use {
            'glepnir/galaxyline.nvim',
            after = {'vscode.nvim'},
            branch = 'main',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
            config = function() require('config._galaxyline') end
        }

        use {
            "ZSaberLv0/ZFVimIM",
            event = "VimEnter",
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

        use {'mhinz/vim-startify'}

        use {'kevinhwang91/nvim-bqf'}

        -- commenter
        use {'tpope/vim-commentary'}

        vim.api.nvim_set_var('use_treesitter', true);
        if vim.api.nvim_get_var('use_treesitter') then
            use {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate',
                config = function() require('config._treesitter') end
            }
            use {'windwp/nvim-ts-autotag'}
            use {'JoosepAlviste/nvim-ts-context-commentstring'}
            use {'p00f/nvim-ts-rainbow', disable = false}
        else
            use {'sheerun/vim-polyglot'}
            use {'luochen1990/rainbow'}
            g.rainbow_active = 1
        end

        use {
            'jiangmiao/auto-pairs',
            config = function() require('config._autopairs').setup() end
        }

        use {
            'lukas-reineke/indent-blankline.nvim',
            event = "VimEnter",
            config = function() require('config._indentline').setup() end
        }
        -- use {
        --     'Yggdroot/indentLine',
        --     config = function() require('config._indentline').setupIndent() end
        -- }

        use {'tpope/vim-surround'}

        use {'PangPangPangPangPang/visual-selection-vim'}
        map('v', '*', ":<C-u>call visual#action('')<CR>/<C-R>=@/<CR><CR>", opts)
        map('v', '#', ":<C-u>call visual#action('')<CR>?<C-R>=@/<CR><CR>", opts)
        map('v', '<leader>r',
            ":call visual#replace('%s/foo//g')<CR><left><left>", {silent = true})

        use {
            'mhinz/vim-grepper',
            cmd = {'GrepperRg', 'Grepper'},
            setup = function() require('config._grep') end
        }

        vim.api.nvim_set_var('use_coc', false);
        if vim.api.nvim_get_var('use_coc') then
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

            -- use {'liuchengxu/vista.vim', cmd = {'Vista'}}
        else
            -- nvim builtin lsp
            use {
                "neovim/nvim-lspconfig",
                requires = {'kabouzeid/nvim-lspinstall'},
                config = function()
                    require("config._lsp_config").config()
                end
            }
            use {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("lsp.lsp_nullls").config();
                end,
                requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
            }

            -- use {
            --     'glepnir/lspsaga.nvim',
            --     config = function()
            --         require("config._lsp_saga").config()
            --     end
            -- }
            use {
                "hrsh7th/nvim-cmp",
                requires = {
                    "onsails/lspkind-nvim", "hrsh7th/cmp-nvim-lua",
                    "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path",
                    "hrsh7th/cmp-buffer", "hrsh7th/cmp-vsnip"
                },
                config = function()
                    require("config._nvim_cmp").config()
                end
            }
            use {
                "hrsh7th/cmp-vsnip",
                wants = "friendly-snippets",
                requires = {
                    'hrsh7th/vim-vsnip-integ', "hrsh7th/vim-vsnip",
                    "rafamadriz/friendly-snippets"
                }
            }
            -- use {
            --     'ms-jpq/coq_nvim',
            --     branch = 'coq',
            --     config = function() require("_coq").config() end
            -- } -- main one
            -- use {'ms-jpq/coq.artifacts', branch = 'artifacts'} -- 9000+ Snippets
            -- use {
            --     "onsails/lspkind-nvim",
            --     event = "BufEnter",
            --     config = function()
            --         -- require("lsp_config").lspkind()
            --     end
            -- }

            use {
                "ray-x/lsp_signature.nvim",
                after = "nvim-lspconfig",
                config = function()
                    require("config._lsp_config").signature()
                end
            }

            use {
                "norcalli/nvim-colorizer.lua",
                event = "BufEnter",
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

        use {'machakann/vim-highlightedyank'}

        use {'tweekmonster/startuptime.vim', cmd = {'StartupTime'}}

        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
                {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
            },
            config = function() require('config._telescope').config() end,
            cmd = {'Telescope'},
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

        use {'szw/vim-maximizer', cmd = {'MaximizerToggle'}}
        map('n', '<c-w>z', ':MaximizerToggle<CR>', {silent = true})
        map('v', '<c-w>z', ':MaximizerToggle<CR>gv', {silent = true})

        -- vim-cool disables search highlighting when you are done searching and re-enables it when you search again.
        use {'romainl/vim-cool'}
        g.CoolTotalMatches = 1

        g.smoothie_base_speed = 20
        use {'psliwka/vim-smoothie'}

        use {
            'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            cmd = {'NvimTreeToggle', 'NvimTreeFindFile'},
            config = function() require('config._gitsigns').setup() end
        }
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function() require('config._tree') end
        }
        use {'tpope/vim-fugitive'}
        use {'rbong/vim-flog'}
        use {'rhysd/git-messenger.vim'}

        use {
            'justinmk/vim-sneak',
            config = function() require('config._sneak').setup() end
        }

        use {'kshenoy/vim-signature'}

        use {'simnalamburt/vim-mundo', cmd = {'MundoToggle'}}
        map('n', '<F6>', ':MundoToggle<CR>', {silent = true})

        -- html
        use {'mattn/emmet-vim'}
        g.user_emmet_expandabbr_key = '<C-y><tab>'
        g.user_emmet_prev_key = '<C-y>p'

        use {'tpope/vim-dadbod', cmd = {'DB'}}
        use {'skywind3000/vim-quickui'}
        g.quickui_border_style = 2
        g.quickui_color_scheme = 'system'

        use {'kana/vim-textobj-user'}
        use {'kana/vim-textobj-function'}
        use {'kana/vim-textobj-indent'}
        use {'kana/vim-textobj-line'}

        -- use {
        --     'Shougo/defx.nvim',
        --     run = ':UpdateRemotePlugins',
        --     requires = {'kristijanhusak/defx-icons', 'kristijanhusak/defx-git'},
        --     config = function()
        --         require('config/defx').config()
        --         require('config/defx').map()
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
