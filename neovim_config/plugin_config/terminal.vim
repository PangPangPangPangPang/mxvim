if has('nvim')
    tnoremap <silent> <Esc> <C-\><C-n>
    tnoremap <silent> <F5> <Esc>:VSTerminalToggle<cr>
    tnoremap <silent> <C-w> <C-\><C-n><C-w>
else
    tmap <silent> <F5> <c-w>:VSTerminalToggle<cr>
endif
let g:vs_terminal_custom_height = 10
