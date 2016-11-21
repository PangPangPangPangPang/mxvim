#!/bin/bash

# cleanup
if [ -f ~/.vimrc ]; then
  rm ~/.vimrc
fi

if [ -d ~/.vim ]; then
  rm -rf ~/.vim
fi

# download vim-plug
mkdir -p ~/.vim/{plugged,autoload}
curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim

cp .vimrc ~/.vimrc

# install vim plugins
vim -E -s <<-EOF
  :source ~/.vimrc
  :PlugInstall
  :PlugClean
  :qa
EOF
