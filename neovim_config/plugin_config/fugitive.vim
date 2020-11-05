function! s:BDExt(ext)
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ "\.'.a:ext.'$"')
  if empty(buffers) |throw "no *.".a:ext." buffer" | endif
  exe 'bd '.join(buffers, ' ')
endfunction
command! -nargs=1 BDExt :call s:BDExt(<f-args>)

noremap <silent><leader>q :cclose<cr> :pclose<cr>
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
" let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'

highlight GitgutterAdd gui=none term=none guibg=none guifg=#8ec07c ctermbg=none ctermfg=Green
highlight GitgutterChange gui=none term=none guibg=none guifg=#fabd2f ctermbg=none ctermfg=Yellow
highlight GitgutterDelete gui=none term=none guibg=none guifg=#fb4934 ctermbg=none ctermfg=Red
highlight GitgutterChangeDelete gui=none term=none guibg=none guifg=#fb4934 ctermbg=none ctermfg=Red
highlight SignatureMarkText gui=none term=none guibg=none guifg=#EBDBB2 ctermbg=none ctermfg=white
