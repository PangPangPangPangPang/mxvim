map <silent> <F2> :Vista!!<cr>
imap <silent> <F2> <Esc>:Vista!!<cr>
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
            \ 'markdown': 'ctags',
            \ 'c': 'ctags',
            \ 'cpp': 'ctags',
            \}
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
let g:vista_echo_cursor_strategy= 'floating_win'
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
