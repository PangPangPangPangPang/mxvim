#!/bin/bash

if [ -f ~/.config/nvim/init.vim ]; then
    rm ~/.config/nvim/init.vim
fi

for var in $*
do
    if [ "$var" = "-r" ];  then
        rm -rf ~/.config/nvim/init.vim
        curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        rm -rf ~/.config/nvim/colors
        mkdir ~/.config/nvim/colors
    fi
done

cp -r ./colors ~/.config/nvim/
cp init.vim ~/.config/nvim/init.vim

nvim -E -s <<-EOF
:source ~/.config/nvim/init.vim
:qa
EOF
nvim +PlugInstall +qall

