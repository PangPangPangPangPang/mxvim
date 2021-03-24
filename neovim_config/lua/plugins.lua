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

end)

vim.cmd [[colorscheme codedark]]
