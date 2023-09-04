#!/bin/bash

#install neovim first
#brew install neovim/neovim/neovim
#pip install neovim
dst_dir="$HOME/.config/nvim"
rm -rf ${dst_dir}
mkdir -p ${dst_dir} 2>/dev/null
# rm -rf ~/.config/coc/

input_db="$(pwd)/pinyin.txt"
if [ ! -f ${input_db} ];then
    curl https://raw.githubusercontent.com/PangPangPangPangPang/ZFVimIM_pinyin/master/misc/pinyin.txt >> ${input_db}
fi

ln -s ${input_db} ${dst_dir}

ln -s "$(pwd)/init.lua" "${dst_dir}/init.lua"
ln -s "$(pwd)/lua" "${dst_dir}/lua"
ln -s "$(pwd)/viml" "${dst_dir}/viml"
ln -s "$(pwd)/coc-settings.json" ${dst_dir}
ln -s "$(pwd)/ginit.vim" ${dst_dir}
ln -s "$(pwd)/.editorconfig" ${dst_dir}

nvim --headless "+Lazy! sync" +qa