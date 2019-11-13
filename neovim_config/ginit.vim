if exists('g:GuiLoaded')
    " Guifont MaxIosevka:h14:l
    Guifont MaxIosevka:h15
    GuiTabline 0
    GuiPopupmenu 0
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
endif
