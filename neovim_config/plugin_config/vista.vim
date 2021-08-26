finish
map <silent> <F2> :Vista!!<cr>
imap <silent> <F2> <Esc>:Vista!!<cr>
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
            \ 'markdown': 'ctags',
            \ 'c': 'ctags',
            \ 'cpp': 'ctags',
            \}
" let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_icon_indent = ['└ ', '│ ']
let g:vista_echo_cursor_strategy= 'floating_win'
let g:vista#renderer#icons = {
            \ 'field': ' ',
            \ 'fields': ' ',
            \ 'enumerator': 'הּ ',
            \ 'enum': 'הּ ',
            \ 'functions': ' ',
            \ 'function': ' ',
            \ 'func': ' ',
            \ 'namespace': '',
            \ 'class': ' ',
            \ 'map': 'פּ ',
            \ 'method': ' ',
            \ 'const': ' ',
            \ 'variables': ' ',
            \ 'var': ' ',
            \ 'property': '襁',
            \ 'subroutine': '羚',
            \ 'interface': '',
            \ 'implementation': ' ',
            \ 'types': ' ',
            \ 'type': ' ',
            \ 'typedef': ' ',
            \ 'packages': ' ',
            \ 'default': ' ',
            \ 'augroup': 'פּ ',
            \ 'macro': ' ',
            \ 'macros': ' ',
            \ 'target': ' ',
            \ 'variable': ' ',
            \ 'modules': ' ',
            \ 'constant': ' ',
            \ 'struct': ' ',
            \ 'module': ' ',
            \ 'typeParameter': ' ',
            \ 'package': ' ',
            \ 'member': ' ',
            \ 'union': '鬒'
            \}
