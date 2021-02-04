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
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
done

cp -r ./colors ~/.vim/
cp .vimrc ~/.vimrc
cp .gvimrc ~/.gvimrc
cp ./neovim_config/coc-settings.json ~/.vim/coc-settings.json
cp ./vimrc.bundle ~/.vim/vimrc.bundle
if [ -f "./vimrc.additional.bundle" ]; then
    cp ./vimrc.additional.bundle ~/.vim/vimrc.additional.bundle
fi

vim -E -s <<-EOF
:source ~/.vimrc
:qa
EOF
vim +PlugInstall +qall
for var in $*
do
    cd ~/.vim/plugged/YouCompleteMe
    if [ "$var" = "-ycm" ]; then
        # python3 install.py --all
         python3 install.py --go-completer --ts-completer
    fi
done

# for var in $*
# do
#     if [ "$var" = "-ycm" ]; then
#         cp ./.ycm_extra_conf.py ~/.ycm_extra_conf.py
#         cd ~/.vim/plugged/YouCompleteMe
#         if [ ! -f "./third_party/ycmd/build.py" ]; then
#             git submodule update --init --recursive
#         fi
#         ./install.py --clang-completer --tern-completer --go-completer
#     fi
#     if [ "$var" = "-jslint" ]; then
#         cp ./javasript/.jshintrc ~/.jshintrc
#     fi
#
#     # to support javascript tagbar run bellow commond in you project after run -eslint
#     # find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags
#     if [ "$var" = "-eslint" ]; then
#         sudo npm install eslint-config-recommended eslint-config-airbnb eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react eslint babel-eslint eslint_d -g
#         sudo npm install -g git+https://github.com/ramitos/jsctags.git
#         cp ./javasript/.eslintrc.js ~/.eslintrc.js
#     fi
# done
