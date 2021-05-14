#!/bin/bash

#install neovim first
#brew install neovim/neovim/neovim
#pip install neovim

dst_dir="$HOME/.config/nvim"
rm -rf ${dst_dir}
mkdir -p ${dst_dir} 2>/dev/null
# rm -rf ~/.config/coc/

ln -s "$(pwd)/basic.vim" ${dst_dir}
ln -s "$(pwd)/colorscheme.vim" ${dst_dir}
ln -s "$(pwd)/coc-settings.json" ${dst_dir}
ln -s "$(pwd)/plugin_config" "${dst_dir}/plugin_config"
ln -s "$(pwd)/lua" "${dst_dir}/lua"
ln -s "$(pwd)/init.lua" "${dst_dir}/init.lua"

nvim --headless +PackerCompile +qa

