#!/bin/bash

#install neovim first
#brew install neovim/neovim/neovim
#pip install neovim

rm -rf ~/.config/nvim/
# rm -rf ~/.config/coc/
mkdir ~/.config/nvim

cp ./basic.vim ~/.config/nvim
cp ./coc-settings.json ~/.config/nvim
cp -r ./plugin_config ~/.config/nvim/plugin_config
cp -r ./lua ~/.config/nvim/lua
# cp -r ./init.lua ~/.config/nvim/init.lua
ln ./init.lua ~/.config/nvim/init.lua

if [ -f ~/.config/nvim/init.vim ]; then
    rm -rf  ~/.config/nvim/init.vim
fi
nvim --headless +PackerInstall +PackerCompile +qa
