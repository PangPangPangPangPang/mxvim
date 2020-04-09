if exists('g:GuiLoaded')
    " Guifont MaxIosevka:h14:l
    Guifont MaxIosevka\ Nerd\ Font:h16
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
endif
