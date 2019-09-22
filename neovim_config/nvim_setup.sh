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
        rm -rf ~/.config/nvim/colors
        mkdir ~/.config/nvim/colors
    fi
done

cp -r ./colors ~/.config/nvim/
cp -r ./syntax ~/.config/nvim/
cp ./plug.vim ~/.config/nvim/
cp -r ./plugin_config ~/.config/nvim/
cp init.vim ~/.config/nvim/init.vim
cp ./coc-settings.json ~/.config/nvim/

for var in $*
do
    if [ "$var" = "-noplugin" ];  then
        rm ~/.config/nvim/plug.vim
        exit
    fi
done
nvim -E -s <<-EOF
:source ~/.config/nvim/init.vim
:qa
EOF
nvim +PlugInstall +qall

