"vim-go
let g:go_code_completion_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

"vim-delve
let g:delve_new_command = 'vnew'
autocmd FileType go nmap <silent> <F3> :DlvDebug<CR>
autocmd FileType go nmap <silent> <F4> :DlvToggleBreakpoint<CR>
