let g:ack_use_cword_for_empty_search = 1
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
let g:ack_use_async = 1
vnoremap <silent> <leader>f :call visual#action('Ack! foo')<cr>
" nnoremap <leader>p :Ack! <space>
nnoremap <leader>f :Ag<cr>

