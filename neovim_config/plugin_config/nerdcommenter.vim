let g:NERDSpaceDelims=1
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters={
            \ 'javascript': { 'left': '//', 'right': '', 'leftAlt': '{/*', 'rightAlt': '*/}' },
            \ 'swift': { 'left': '//'},
            \}
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1

" User <leader>cm to use its alternate delimiters.
" nmap <leader>/ :Commentary<cr>
" vmap <leader>/ :Commentary<cr>
vmap <leader>/ <Plug>NERDCommenterToggle
nmap <leader>/ <Plug>NERDCommenterToggle
map <leader>? <Plug>NERDCommenterAltDelims

