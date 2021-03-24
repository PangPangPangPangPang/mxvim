local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
        cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
        -- Packer itself
        use {'wbthomason/packer.nvim', opt = true}

        use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
        use {'windwp/nvim-ts-autotag'}
        use {'JoosepAlviste/nvim-ts-context-commentstring'}

        use {'jiangmiao/auto-pairs'}

        -- Indentation tracking
        use {
                'lukas-reineke/indent-blankline.nvim',
                branch = 'lua',
                setup = [[require('config.indentline')]]
        }

        use {'PangPangPangPangPang/visual-selection-vim'}
        use {'mhinz/vim-grepper', cmd = {'GrepperRg', 'Grepper'}}

        use {'neoclide/coc.nvim', branch = 'release'}


        use {'ryanoasis/vim-devicons'}
        vim.g.devicons_install = 1
        use {'tomasiser/vim-code-dark'}

        use {'tpope/vim-rsi'}

        use {'romainl/vim-cool'}

        use {'machakann/vim-highlightedyank'}

        use {'liuchengxu/vista.vim', cmd = {'Vista'}}

        use {'Shougo/defx.nvim', requires = {'kristijanhusak/defx-icons', 'kristijanhusak/defx-git'}}

        use {'tweekmonster/startuptime.vim', cmd = 'StartupTime'}


        use {'kyazdani42/nvim-web-devicons'}
        use {'glepnir/galaxyline.nvim'}

        use {'nvim-lua/popup.nvim'}
        use {'nvim-lua/plenary.nvim'}
        use {'nvim-telescope/telescope.nvim'}

        use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = {'MarkdownPreview'}}

        use {'szw/vim-maximizer', cmd = {'MaximizerToggle'}}

        use {'airblade/vim-gitgutter'}
        use {'tpope/vim-fugitive'}
        use {'junegunn/gv.vim'}
        use {'rhysd/git-messenger.vim'}
        use {'honza/vim-snippets'}
        use {'rhysd/clever-f.vim'}
        use {'kshenoy/vim-signature'}
        use {'simnalamburt/vim-mundo'}
        use {'skywind3000/vim-terminal-help'}
        use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
        use {'RRethy/vim-illuminate'}
        use {'tpope/vim-dadbod', cmd = {'DB'}}
        use {'skywind3000/vim-quickui'}
        use {'kana/vim-textobj-user'}
        use {'kana/vim-textobj-function'}
        use {'kana/vim-textobj-indent'}
        use {'kana/vim-textobj-line'}
end)

vim.cmd [[colorscheme codedark]]
