#!/bin/bash

#install FE environment run below
#sh setup.sh -r -ycm -eslint

# cleanup
if [ -f ~/.vimrc ]; then
    rm ~/.vimrc
fi

for var in $*
do
    if [ "$var" = "-r" ];  then
        rm -rf ~/.vim
        git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
        rm -rf ~/.vim/colors
        mkdir ~/.vim/colors
        cp ./molokai.vim ~/.vim/colors/molokai.vim
    fi
done

cp .vimrc ~/.vimrc
cp ./vimrc.bundle ~/.vim/vimrc.bundle

vim -E -s <<-EOF
:source ~/.vimrc
:qa
EOF
vim +BundleInstall +qall

for var in $*
do
    if [ "$var" = "-ycm" ]; then
        cp ./.ycm_extra_conf.py ~/.ycm_extra_conf.py
        cd ~/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer --system-libclang --tern-completer
    fi
    if [ "$var" = "-jslint" ]; then 
        cp ./javasript/.jshintrc ~/.jshintrc
    fi
    if [ "$var" = "-eslint" ]; then 
        cp ./javasript/.eslintrc.js ~/.eslintrc.js
    fi
    if [ "$var" = "-nvim" ]; then #install neovim first
	mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
	ln -s ~/.vim $XDG_CONFIG_HOME/nvim
	ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
    fi
done
