if exists('g:GuiLoaded')
    " Guifont MaxIosevka:h16:l
    Guifont MaxIosevka\ Nerd\ Font:h12
    GuiTabline 0
    GuiPopupmenu 0
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
    set mouse=a

    " Paste with middle mouse click
    vmap <LeftRelease> "*ygv

    " Paste with <Shift> + <Insert>
    imap <S-Insert> <C-R>*
    set path=/usr/local/sbin:/var/folders/gy/5gv587152fq9djwvyt0n76f80000gp/T/fnm_multishell_664_1622117975026/bin:/Users/max/.yarn/bin:/Users/max/.config/yarn/global/node_modules/.bin:/Users/max/.zinit/plugins/junegunn---fzf-bin:/Users/max/.zinit/polaris/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/opt/puppetlabs/bin:/usr/local/munki:/Library/Apple/usr/bin:/Users/max/mysteryx_flutter/.flutterw/cache/dist/engine/bin:/Users/max/go/bin:/Users/max/.local/share/nvim/site/pack/packer/start/fzf/bin:/Users/max/.local/share/nvim/site/pack/packer/start/vim-terminal-help/tools/utils/
endif
