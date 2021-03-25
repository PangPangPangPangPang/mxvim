#!/bin/bash

#install neovim first
#brew install neovim/neovim/neovim
#pip install neovim

if [ -f ~/.config/nvim/init.vim ]; then
    rm -rf  ~/.config/nvim/init.vim
fi
for var in $*
do
    if [ "$var" = "-r" ];  then
        rm -rf ~/.config/nvim/
        rm -rf ~/.config/coc/
        curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
done

cp -r ./ ~/.config/nvim/

if [ -f ~/.config/nvim/init.lua ]; then
    rm -rf  ~/.config/nvim/init.lua
fi

for var in $*
do
    if [ "$var" = "--no-plugin" ];  then
        exit
    fi
done
nvim -E -s <<-EOF
:source ~/.config/nvim/init.vim
:qa
EOF
#nvim +PlugCompile +qall
