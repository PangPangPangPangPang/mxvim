#!/bin/bash

#install neovim first
#brew install neovim/neovim/neovim
#pip install neovim

sudo rm -rf ~/.config/nvim/
sudo rm -rf ~/.config/coc/

cp -r ./ ~/.config/nvim/

if [ -f ~/.config/nvim/init.vim ]; then
    rm -rf  ~/.config/nvim/init.vim
fi
nvim -E -s <<-EOF
:source ~/.config/nvim/init.lua
:qa
EOF
nvim +PackerInstall +qall
