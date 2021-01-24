" Set ale disable as default
let g:ale_enabled = 0
" let g:ale_sign_column_always = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 100
let g:ale_lint_delay = 1000
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0

if has('nvim') 
    let g:ale_virtualtext_cursor = 1
    let g:ale_echo_cursor = 0
else
    let g:ale_echo_cursor = 1
endif
let g:ale_virtualtext_prefix = '■ '
" let g:ale_lint_on_enter = 0

let g:ale_c_ccls_executable = 'ccls'

let g:ale_sign_warning = ' '
let g:ale_sign_error = ' '
let g:ale_statusline_format = ['x %d', '> %d', '⬥ ok']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_highlight_linenrs = 1
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
"
let g:ale_linters = {'jsx': ['stylelint', 'eslint'],
            \        'javascript' : ['eslint'],
            \        'typescript' : ['eslint'],
            \        'typescriptreact' : ['eslint'],
            \        'html' : ['htmlhint'],
            \        'css' : ['stylelint'],
            \        'python' : ['flake8'],
            \        'go' : ['golint'],
            \        'cfamily' : ['ccls'],
            \        'dart' : ['dartanalyzer'],
            \       }
let g:ale_linter_aliases = {
            \   'cfamily': ['c', 'cpp', 'objc', 'objcpp'],
            \   'xml': 'html',
            \   'ttss': 'css',
            \   'Dockerfile': 'dockerfile',
            \   'csh': 'sh',
            \   'javascriptreact': ['javascript', 'jsx'],
            \   'plaintex': 'tex',
            \   'ps1': 'powershell',
            \   'rmarkdown': 'r',
            \   'rmd': 'r',
            \   'systemverilog': 'verilog',
            \   'typescriptreact': ['typescript', 'tsx'],
            \   'verilog_systemverilog': ['verilog_systemverilog', 'verilog'],
            \   'vimwiki': 'markdown',
            \   'vue': ['vue', 'javascript'],
            \   'xsd': ['xsd', 'xml'],
            \   'xslt': ['xslt', 'xml'],
            \   'zsh': 'sh',
            \              }
let g:ale_fixers = {
            \       'javascript': ['eslint'],
            \       'typescript' : ['eslint'],
            \       'typescriptreact' : ['eslint'],
            \       'dart': ['dartfmt'],
            \       'go': ['gofmt', 'goimports'],
            \        'html' : ['htmlhint'],
            \        'css' : ['stylelint'],
            \       '*': ['remove_trailing_lines', 'trim_whitespace'],
            \      }
let g:ale_fix_on_save_ignore = {
            \      'vim': ['remove_trailing_lines', 'trim_whitespace'],
            \      }
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

map <silent> <leader>s :ALEToggle<cr>
