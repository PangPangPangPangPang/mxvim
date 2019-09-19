if has('nvim')
    tnoremap <silent> <F5> <C-\><C-n> :VSTerminalToggle<cr>
    tnoremap <silent> <C-w> <C-\><C-n><C-w>
    tnoremap <silent> <Esc> <C-\><C-n>
else
    tmap <silent> <F5> <c-w>:VSTerminalToggle<cr>
endif
let g:vs_terminal_custom_height = 10
