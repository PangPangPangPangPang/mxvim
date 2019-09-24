let g:grepper = {
    \ 'tools': ['ag', 'rg', 'ack', 'grep', 'findstr', 'pt', 'git'],
    \ 'pt': {
    \   'grepprg':    'pt --nocolor --nogroup',
    \   'grepformat': '%f:%l:%m',
    \   'escape':     '\+*^$()[]',
    \ }}
let g:grepper.highlight = 1
if executable('rg') 
    nnoremap <leader>f :GrepperRg<space>
    vnoremap <silent> <leader>f :call visual#action('GrepperRg foo')<cr>
elseif executable('ag')
    nnoremap <leader>f :GrepperAg<space>
    vnoremap <silent> <leader>f :call visual#action('GrepperAg foo')<cr>
endif
