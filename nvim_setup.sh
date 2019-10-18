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
    fi
done

cp -r ./neovim_config/ ~/.vim/
cp -r ./neovim_config/init.vim ~/.vimrc
cp -r ./.gvimrc ~/.gvimrc

for var in $*
do
    if [ "$var" = "-noplugin" ];  then
        rm rf ~/.vim/plug.vim
        exit
    fi
done

vim -E -s <<-EOF
:source ~/.vimrc
:qa
EOF
vim +PlugInstall +qall

