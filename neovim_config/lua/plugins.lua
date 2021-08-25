local fn = vim.fn
local cmd = vim.cmd
local g = vim.g

local map = require('utils').map
local opts = {noremap = true, silent = true}

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

        use {'tomasiser/vim-code-dark'}
        -- use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
        use {"lifepillar/vim-gruvbox8"}
        use {"Mofiqul/vscode.nvim"}
        use {"PangPangPangPangPang/miramare", branch = 'develop'}

        use {
            'glepnir/galaxyline.nvim',
            config = function() require('_galaxyline') end
        }

        use {
            "ZSaberLv0/ZFVimIM",
            requires = {
                "ZSaberLv0/ZFVimJob", "ZSaberLv0/ZFVimGitUtil",
                "PangPangPangPangPang/ZFVimIM_pinyin_base",
                "ZSaberLv0/ZFVimIM_openapi"
            }
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
                config = function() require('treesitter') end
            }
            use {'windwp/nvim-ts-autotag'}
            use {'JoosepAlviste/nvim-ts-context-commentstring'}
            use {'p00f/nvim-ts-rainbow', disable = false}
        else
            use {'sheerun/vim-polyglot'}
            use {'luochen1990/rainbow'}
            g.rainbow_active = 1
        end

        use {'jiangmiao/auto-pairs'}

        use {
            'lukas-reineke/indent-blankline.nvim',
            setup = function() require('indentline') end
        }

        use {'tpope/vim-surround'}

        use {'PangPangPangPangPang/visual-selection-vim'}
        map('v', '*', ":<C-u>call visual#action('')<CR>/<C-R>=@/<CR><CR>", opts)
        map('v', '#', ":<C-u>call visual#action('')<CR>?<C-R>=@/<CR><CR>", opts)
        map('v', '<leader>r',
            ":call visual#replace('%s/foo//g')<CR><left><left>", {silent = true})

        use {'mhinz/vim-grepper', cmd = {'GrepperRg', 'Grepper'}}

        vim.api.nvim_set_var('use_coc', false);
        if vim.api.nvim_get_var('use_coc') then
            use {'neoclide/coc.nvim', branch = 'release'}

            use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
            g.Illuminate_highlightUnderCursor = 1
            g.Illuminate_ftblacklist = {'defx', 'vista', 'nerdtree'}
        else
            -- nvim builtin lsp
            use {
                "neovim/nvim-lspconfig",
                requires = {'kabouzeid/nvim-lspinstall'},
                config = function()
                    require("lsp_config").config()
                end
            }
            use {
                'glepnir/lspsaga.nvim',
                config = function() require("lsp_saga").config() end
            }
            -- use {
            --     "hrsh7th/nvim-compe",
            --     event = "InsertEnter",
            --     config = function()
            --         require("nvim_compe").config()
            --     end,
            --     wants = {"LuaSnip"},
            --     requires = {
            --         {
            --             "L3MON4D3/LuaSnip",
            --             wants = "friendly-snippets",
            --             event = "InsertCharPre",
            --             config = function()
            --                 require("nvim_compe").snippets()
            --             end
            --         }, "rafamadriz/friendly-snippets"
            --     }
            -- }
            use {'L3MON4D3/LuaSnip'}
            use {
                "hrsh7th/nvim-cmp",
                -- requires = {"", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-vsnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path"},
                config = function()
                    require("nvim_cmp").config()
                end,
            }
            use {"hrsh7th/cmp-buffer"}
            use {"hrsh7th/cmp-nvim-lua"}
            use {'saadparwaiz1/cmp_luasnip'}
            use {"hrsh7th/cmp-nvim-lsp"}
            use {"hrsh7th/cmp-path"}
            -- use {
            --     'ms-jpq/coq_nvim',
            --     branch = 'coq',
            --     config = function() require("_coq").config() end
            -- } -- main one
            -- use {'ms-jpq/coq.artifacts', branch = 'artifacts'} -- 9000+ Snippets
            use {
                "onsails/lspkind-nvim",
                event = "BufEnter",
                config = function()
                    require("lsp_config").lspkind()
                end
            }

            use {
                "ray-x/lsp_signature.nvim",
                after = "nvim-lspconfig",
                config = function()
                    require("lsp_config").signature()
                end
            }

            use {
                "norcalli/nvim-colorizer.lua",
                event = "BufEnter",
                config = function() require'colorizer'.setup() end
            }

        end

        use {
            'sbdchd/neoformat',
            cmd = 'Neoformat',
            setup = function() require('neoformat').config() end
        }

        use {'machakann/vim-highlightedyank'}

        use {'liuchengxu/vista.vim', cmd = {'Vista'}}

        use {'tweekmonster/startuptime.vim', cmd = {'StartupTime'}}

        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
            config = function() require('telescope_config').config() end,
            cmd = {'Telescope'},
            setup = function() require('telescope_config').map() end
        }

        use {
            'iamcco/markdown-preview.nvim',
            run = 'cd app && yarn install',
            cmd = {'MarkdownPreview'}
        }

        use {
            'voldikss/vim-floaterm',
            cmd = {'FloatermToggle', 'FloatermNew'},
            setup = function() require('vim_floaterm').map() end
        }

        use {'szw/vim-maximizer', cmd = {'MaximizerToggle'}}
        map('n', '<c-w>z', ':MaximizerToggle<CR>', {silent = true})
        map('v', '<c-w>z', ':MaximizerToggle<CR>gv', {silent = true})

        -- vim-cool disables search highlighting when you are done searching and re-enables it when you search again.
        use {'romainl/vim-cool'}
        g.CoolTotalMatches = 1

        use {
            'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            cmd = {'NvimTreeToggle', 'NvimTreeFindFile'},
            config = function() require('_gitsigns').setup() end
        }
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function() require('tree') end
        }
        use {'tpope/vim-fugitive'}
        use {'junegunn/gv.vim'}
        use {'rhysd/git-messenger.vim'}
        use {'honza/vim-snippets'}

        use {'justinmk/vim-sneak'}

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
