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
require('packer').startup(function(use)
    -- Packer itself
    use {'wbthomason/packer.nvim', opt = true}

    use {'ryanoasis/vim-devicons'}
    g.devicons_install = 1

    -- Readline style insertion
    use {'tpope/vim-rsi'}

    use {'mhinz/vim-startify'}

    use {'luochen1990/rainbow'}
    g.rainbow_active = 1

    -- commenter
    use {'b3nj5m1n/kommentary'}

    use {'windwp/nvim-ts-autotag'}
    use {'JoosepAlviste/nvim-ts-context-commentstring'}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function() require('treesitter') end}

    use {'jiangmiao/auto-pairs'}

    -- Indentation tracking
    g.indentLine_char = '│'
    g.indentLine_fileTypeExclude = {'markdown', 'coc-explorer'}
    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = 'lua',
        setup = [[require('config.indentline')]]
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

    use {'neoclide/coc.nvim', branch = 'release'}

    use {'tomasiser/vim-code-dark'}

    -- vim-cool disables search highlighting when you are done searching and re-enables it when you search again.
    use {'romainl/vim-cool'}
    g.CoolTotalMatches = 1

    use {'machakann/vim-highlightedyank'}

    use {'liuchengxu/vista.vim', cmd = {'Vista'}}

    use {'Shougo/defx.nvim',run = ':UpdateRemotePlugins', requires = {'kristijanhusak/defx-icons', 'kristijanhusak/defx-git'}}

    use {'tweekmonster/startuptime.vim', cmd = {'StartupTime'}}

    use {'kyazdani42/nvim-web-devicons'}
    use {'glepnir/galaxyline.nvim', config = function() require('_galaxyline') end}

    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}, config = function() require('_telescope') end}

    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = {'MarkdownPreview'}}

    use {'szw/vim-maximizer', cmd = {'MaximizerToggle'}}
    map('n', '<c-w>z', ':MaximizerToggle<CR>', {silent = true})
    map('v', '<c-w>z', ':MaximizerToggle<CR>gv', {silent = true})


    use {'airblade/vim-gitgutter'}
    use {'tpope/vim-fugitive'}
    use {'junegunn/gv.vim'}
    use {'rhysd/git-messenger.vim'}
    use {'honza/vim-snippets'}

    use {'rhysd/clever-f.vim'}
    map('', ';', '<Plug>(clever-f-repeat-forward)', {silent = true})
    map('', ',', '<Plug>(clever-f-repeat-back)', {silent = true})

    use {'kshenoy/vim-signature'}

    use {'simnalamburt/vim-mundo'}
    map('n', '<F6>', ':MundoToggle<CR>', {silent = true})

    use {'skywind3000/vim-terminal-help'}
    g.terminal_auto_insert = 1
    g.terminal_key = "<F5>"
    g.terminal_cwd = 2
    g.terminal_height = 20
    g.terminal_list = 0
    g.terminal_kill = "term"

    use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
    g.Illuminate_highlightUnderCursor = 1
    g.Illuminate_ftblacklist = {'defx', 'vista', 'nerdtree'}

    -- html
    use {'mattn/emmet-vim'}
    g.user_emmet_expandabbr_key = '<C-y><tab>'
    g.user_emmet_prev_key = '<C-y>p'

    use {'RRethy/vim-illuminate'}
    use {'tpope/vim-dadbod', cmd = {'DB'}}
    use {'skywind3000/vim-quickui'}
    g.quickui_border_style = 2
    g.quickui_color_scheme = 'system'

    use {'kana/vim-textobj-user'}
    use {'kana/vim-textobj-function'}
    use {'kana/vim-textobj-indent'}
    use {'kana/vim-textobj-line'}
end)

vim.cmd [[colorscheme codedark]]
