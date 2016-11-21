#!/bin/bash

# cleanup
if [ -f ~/.vimrc ]; then
  rm ~/.vimrc
fi

if [ "$1" = "-r" ]; then
  rm -rf ~/.vim
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    cp ./molokai.vim ~/.vim/colors/molokai.vim
fi

cp .vimrc ~/.vimrc

vim -E -s <<-EOF
  :source ~/.vimrc
  :qa
EOF
vim +BundleInstall +qall
