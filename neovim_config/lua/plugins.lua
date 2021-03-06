local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local map = require('utils').map

-- Automatically install packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end


cmd [[packadd packer.nvim]]
require('packer').startup({function(use)
    -- Packer itself
    use {'wbthomason/packer.nvim', opt = true}

    use {'ryanoasis/vim-devicons'}
    g.devicons_install = 1

    use {'tomasiser/vim-code-dark'}
    -- use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use {"lifepillar/vim-gruvbox8"}
    use {"Mofiqul/vscode.nvim"}
    use {"PangPangPangPangPang/miramare", branch= 'develop'}

    -- Readline style insertion
    use {'tpope/vim-rsi'}

    use {'mhinz/vim-startify'}
    use {'brglng/vim-im-select'}
    g.im_select_default = 'com.apple.keylayout.US'

    -- use {'luochen1990/rainbow'}
    -- g.rainbow_active = 1

    use {'romainl/vim-qf'}
    use {'kevinhwang91/nvim-bqf'}

    -- commenter
    -- use {'b3nj5m1n/kommentary'}
    use {'tpope/vim-commentary'}

    vim.api.nvim_set_var('use_treesitter', true);
    if vim.api.nvim_get_var('use_treesitter') then
        use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function() require('treesitter') end}
        use {'windwp/nvim-ts-autotag'}
        use {'JoosepAlviste/nvim-ts-context-commentstring'}
        use {'p00f/nvim-ts-rainbow', disable = false}
    else
        use {'sheerun/vim-polyglot'}
        use {'luochen1990/rainbow'}
        g.rainbow_active = 1
    end

    use {'jiangmiao/auto-pairs'}
    -- use {'Raimondi/delimitMate'}

    -- Indentation tracking
    g.indentLine_char = '│'
    g.indent_blankline_use_treesitter = true
    g.indentLine_faster = 1
    g.indentLine_fileTypeExclude = {'tex', 'markdown', 'txt', 'startify', 'packer', 'coc-explorer'}
    g.indent_blankline_show_first_indent_level = false
    g.indent_blankline_show_trailing_blankline_indent = false
    use {
        'lukas-reineke/indent-blankline.nvim',
        -- requires = {'Yggdroot/indentLine'},
        -- branch = 'lua',
        -- setup = [[require('config.indentline')]]
    }

    -- use {'mg979/vim-visual-multi'}
    -- vim.api.nvim_set_var('VM_maps', {'Remove Region' = '<c-p'})

    use {'tpope/vim-surround'}
    -- map('n', '<leader>]', "\m\`\$v\^S\]\`\`", {silent = true})


    use {'PangPangPangPangPang/visual-selection-vim'}
    map('v', '*', ":<C-u>call visual#action('')<CR>/<C-R>=@/<CR><CR>", {silent = true})
    map('v', '#', ":<C-u>call visual#action('')<CR>?<C-R>=@/<CR><CR>", {silent = true})
    map('v', '<leader>r', ":call visual#replace('%s/foo//g')<CR><left><left>", {silent = true})

    use {'mhinz/vim-grepper', cmd = {'GrepperRg', 'Grepper'}}

    vim.api.nvim_set_var('use_coc', true);
    if vim.api.nvim_get_var('use_coc') then
        -- coc lsp
        use {'neoclide/coc.nvim', branch = 'release'}
        -- use {'RRethy/vim-illuminate'}
    else 
        -- nvim builtin lsp
        use {
            "neovim/nvim-lspconfig",
            config = function()
                require("lsp_config").config()
            end
        }
        use {
            'glepnir/lspsaga.nvim',
            config = function()
                require("lsp_saga").config()
            end
        }
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("nvim_compe").config()
            end,
            wants = {"LuaSnip"},
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require("nvim_compe").snippets()
                    end
                },
                "rafamadriz/friendly-snippets"
            }
        }
    end

    -- use {'prettier/vim-prettier', run= 'yarn install'}
    use {'sbdchd/neoformat', cmd = 'Neoformat', config = function() require('neoformat') end}


    use {'machakann/vim-highlightedyank'}

    use {'liuchengxu/vista.vim', cmd = {'Vista'}}

    use {'Shougo/defx.nvim',run = ':UpdateRemotePlugins', requires = {'kristijanhusak/defx-icons', 'kristijanhusak/defx-git'}}

    use {'tweekmonster/startuptime.vim', cmd = {'StartupTime'}}

    use {'kyazdani42/nvim-web-devicons'}
    use {'glepnir/galaxyline.nvim', config = function() require('_galaxyline') end}

    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}, config = function() require('_telescope') end}
    --[[ use {'junegunn/fzf', rtp = '~/.fzf', run = './install --all'}
    use {'junegunn/fzf.vim'} ]]

    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = {'MarkdownPreview'}}

    use {'voldikss/vim-floaterm'}
    vim.api.nvim_command('hi! link FloatermBorder Directory')
    g.floaterm_title = '$1/$2'

    map('n', '<F5>', ":FloatermToggle default<CR>", {silent = true})
    map('t', '<F5>', "<C-\\><C-n>:FloatermToggle default<CR>", {silent = true})
    map('t', '<esc>', "<C-\\><C-n>:FloatermKill<CR>", {silent = true})
    map('n', '<leader>lg', ":FloatermNew --width=0.8 --height=0.8 lazygit<CR>", {silent = true})

    -- g.lazygit_floating_window_use_plenary = 0
    -- map('n', '<leader>lg', ":LazyGit<CR>", {silent = true})

    use {'szw/vim-maximizer', cmd = {'MaximizerToggle'}}
    map('n', '<c-w>z', ':MaximizerToggle<CR>', {silent = true})
    map('v', '<c-w>z', ':MaximizerToggle<CR>gv', {silent = true})

    -- vim-cool disables search highlighting when you are done searching and re-enables it when you search again.
    use {'romainl/vim-cool'}
    g.CoolTotalMatches = 1

    use {'airblade/vim-gitgutter'}
    use {'tpope/vim-fugitive'}
    use {'junegunn/gv.vim'}
    use {'rhysd/git-messenger.vim'}
    use {'honza/vim-snippets'}

    -- use {'rhysd/clever-f.vim'}
    use {'justinmk/vim-sneak'}

    use {'kshenoy/vim-signature'}

    use {'simnalamburt/vim-mundo'}
    map('n', '<F6>', ':MundoToggle<CR>', {silent = true})

    use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
    g.Illuminate_highlightUnderCursor = 1
    g.Illuminate_ftblacklist = {'defx', 'vista', 'nerdtree'}

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
end,
config = {
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
}})
