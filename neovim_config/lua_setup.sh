#!/bin/bash

#install neovim first
#brew install neovim/neovim/neovim
#pip install neovim

rm -rf ~/.config/nvim/
rm -rf ~/.config/coc/
mkdir ~/.config/nvim

cp -r ./lua ~/.config/nvim/lua
cp -r ./init.lua ~/.config/nvim/init.lua

if [ -f ~/.config/nvim/init.vim ]; then
    rm -rf  ~/.config/nvim/init.vim
fi
nvim -E -s <<-EOF
:source ~/.config/nvim/init.lua
:qa
EOF
# nvim +PackerCompile +PackerSync
