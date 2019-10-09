let g:ale_sign_column_always = 0
" Set ale disable as default
let g:ale_enabled = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_enter = 0

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '◎'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_highlight_linenrs = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign
"
let g:ale_linters = {'jsx': ['stylelint', 'eslint'],
            \'python' : ['flake8'],
            \'go' : ['golint'],
            \ }
let g:ale_linter_aliases = {'jsx': 'css'}
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'go': ['gofmt', 'goimports'],
\}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_fix_on_save = 1

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

map <silent> <leader>s :ALEToggle<cr>

