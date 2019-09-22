#!/bin/bash

#install neovim first
#brew install neovim/neovim/neovim
#pip install neovim

if [ -f ~/.vimrc ]; then
    rm ~/.vimrc
fi

for var in $*
do
    if [ "$var" = "-r" ];  then
        rm -rf ~/.vim
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        rm -rf ~/.vim/colors
        mkdir ~/.vim/colors
    fi
done

cp -r ./neovim_config/colors ~/.vim/
cp -r ./neovim_config/syntax ~/.vim/
cp -r ./neovim_config/plugin_config ~/.vim/
cp ./neovim_config/plug.vim ~/.vim/
cp ./neovim_config/init.vim ~/.vimrc
cp ./neovim_config/coc-settings.json ~/.vim/

for var in $*
do
    if [ "$var" = "-noplugin" ];  then
        rm ~/.vim/.vimrc
        exit
    fi
done

vim -E -s <<-EOF
:source ~/.vimrc
:qa
EOF
vim +PlugInstall +qall

