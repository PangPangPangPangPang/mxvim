if !Installed("defx.nvim")
    finish
endif
map <silent> <F1> :Defx -toggle -resume -winwidth=40 -direction=topleft -split=vertical -ignored-files=.*,*.d<cr>
map <silent> <leader>j :Defx  -split=vertical -ignored-files=.*,*.d -winwidth=40 -direction=topleft `getcwd()` -search=`expand('%:p')`<cr>
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    set nonu
    " Define mappings
    nnoremap <silent><buffer><expr> z<CR>
                \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> dc
                \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> dm
                \ defx#do_action('move')
    nnoremap <silent><buffer><expr> dp
                \ defx#do_action('paste')
    " nnoremap <silent><buffer><expr> l
    " \ defx#do_action('open')
    nnoremap <silent><buffer><expr> dV
                \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> dS
                \ defx#do_action('open', 'split')
    nnoremap <silent><buffer><expr> dP
                \ defx#do_action('open', 'pedit')
    nnoremap <silent><buffer><expr> do
                \ defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> dK
                \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> dN
                \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> dM
                \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> dC
                \ defx#do_action('toggle_columns', 'indent:git:mark:icon:filename:type:size:time')
    " nnoremap <silent><buffer><expr> S
    "             \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> dd
                \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> dr
                \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> d!
                \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> dx
                \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> dyy
                \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> d.
                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> d;
                \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> du
                \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> d~
                \ defx#do_action('cd', [getcwd()])
    nnoremap <silent><buffer><expr> dq
                \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> d<Space>
                \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> d*
                \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> dj
                \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> dk
                \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> d<C-l>
                \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> d<C-g>
                \ defx#do_action('print')
    nnoremap <silent><buffer><expr> dcd
                \ defx#do_action('change_vim_cwd')
endfunction

autocmd FIleType defx nnoremap <silent> <buffer> <tab> :silent <c-u> :silent WhichKey 'd'<CR>
autocmd FIleType defx vnoremap <silent> <buffer> <tab> :silent <c-u> :silent WhichKeyVisual 'd'<CR>
" 
if Installed("vim-devicons")
    call defx#custom#option('_', {
                \ 'columns': 'mark:indent:git:icons:filename:type:size:time',
                \ })
else
    call defx#custom#option('_', {
                \ 'columns': 'mark:indent:git:icon:filename:type:size:time',
                \ })
endif
" 
call defx#custom#column('icon', {
            \ 'directory_icon': '▶',
            \ 'opened_icon': '▼',
            \ 'root_icon': '❤',
            \ })
call defx#custom#column('filename', {
            \ 'min_width': 60,
            \ 'max_width': 400,
            \ })

call defx#custom#column('mark', {
            \ 'readonly_icon': '',
            \ 'selected_icon': '✔',
            \ })
call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })
" 
" 
let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 2
let g:defx_icons_directory_icon = ' '
let g:defx_icons_mark_icon = '*'
let g:defx_icons_copy_icon = ' '
let g:defx_icons_move_icon = ' '
let g:defx_icons_parent_icon = ' '
let g:defx_icons_default_icon = ' '
let g:defx_icons_directory_symlink_icon = ' '
" Options below are applicable only when using "tree" feature
let g:defx_icons_root_opened_tree_icon = ' '
let g:defx_icons_nested_opened_tree_icon = ' '
let g:defx_icons_nested_closed_tree_icon = ' '
