if !Installed("nerdtree")
    map <silent> <F1> :Defx -toggle -resume -winwidth=40 -direction=topleft -split=vertical -ignored-files=.*,*.d<cr>
    map <silent> <leader>j :Defx  -split=vertical -ignored-files=.*,*.d -winwidth=40 -direction=topleft `getcwd()` -search=`expand('%:p')`<cr>
    autocmd FileType defx call s:defx_my_settings()
    function! s:defx_my_settings() abort
        " Define mappings
        nnoremap <silent><buffer><expr> <2-LeftMouse> 
                    \ defx#is_directory() ?
                    \ defx#do_action('open_or_close_tree') :
                    \ defx#do_action('drop')
        nnoremap <silent><buffer><expr> <CR>
                    \ defx#is_directory() ?
                    \ defx#do_action('open_directory') :
                    \ defx#do_action('multi', ['drop', 'quit'])
        nnoremap <silent><buffer><expr> c
                    \ defx#do_action('copy')
        nnoremap <silent><buffer><expr> m
                    \ defx#do_action('move')
        nnoremap <silent><buffer><expr> p
                    \ defx#do_action('paste')
        " nnoremap <silent><buffer><expr> l
        " \ defx#do_action('open')
        nnoremap <silent><buffer><expr> v
                    \ defx#do_action('drop', 'vsplit')
        nnoremap <silent><buffer><expr> s
                    \ defx#do_action('drop', 'split')
        nnoremap <silent><buffer><expr> P
                    \ defx#do_action('open', 'pedit')
        nnoremap <silent><buffer><expr> o
                    \ defx#do_action('open_or_close_tree')
        nnoremap <silent><buffer><expr> o
                    \ defx#is_directory() ?
                    \ defx#do_action('open_or_close_tree') :
                    \ defx#do_action('drop')
        nnoremap <silent><buffer><expr> C
                    \ defx#do_action('toggle_columns', 'indent:git:mark:icon:filename:type:size:time')
        nnoremap <silent><buffer><expr> !
                    \ defx#do_action('execute_command')
        nnoremap <silent><buffer><expr> x
                    \ defx#do_action('execute_system')
        nnoremap <silent><buffer><expr> ;
                    \ defx#do_action('repeat')
        nnoremap <silent><buffer><expr> u
                    \ defx#do_action('cd', ['..'])
        nnoremap <silent><buffer><expr> ~
                    \ defx#do_action('cd', [getcwd()])
        nnoremap <silent><buffer><expr> q
                    \ defx#do_action('quit')
        nnoremap <silent><buffer><expr> <Space>
                    \ defx#do_action('toggle_select') . 'j'
        nnoremap <silent><buffer><expr> *
                    \ defx#do_action('toggle_select_all')
        nnoremap <silent><buffer><expr> j
                    \ line('.') == line('$') ? 'gg' : 'j'
        nnoremap <silent><buffer><expr> k
                    \ line('.') == 1 ? 'G' : 'k'
        nnoremap <silent><buffer><expr> <C-l>
                    \ defx#do_action('redraw')
        nnoremap <silent><buffer><expr> <C-g>
                    \ defx#do_action('print')
        nnoremap <silent><buffer><expr> cd
                    \ defx#do_action('change_vim_cwd')
    endfunction
    function s:open_defx_menu() abort
        let content = [
                    \ [ 'Copy file             &c', "call defx#call_action('copy')" ],
                    \ [ 'Paste file            &p', "call defx#call_action('paste')" ],
                    \ [ 'Rename file           &r', "call defx#call_action('rename')" ],
                    \ [ 'Move file             &m', "call defx#call_action('move')" ],
                    \ [ 'Delete file           &d', "call defx#call_action('remove')" ],
                    \ [ 'New Directory         &N', "call defx#call_action('new_directory')" ],
                    \ [ 'New Files             &n', "call defx#call_action('new_multiple_files')" ],
                    \ [ 'Yank Path             &y', "call defx#call_action('yank_path')" ],
                    \ [ 'Toggle ignored files  &.', "call defx#call_action('toggle_ignored_files')" ],
                    \ [ 'Go back               &u', "call defx#call_action('cd', ['..'])" ],
                    \ [ 'Go Root               &R', "call defx#call_action('cd', [getcwd()])" ],
                    \ [ 'Change Root           &C', "call defx#call_action(change_vim_cwd)" ],
                    \]
        let opts = {'title': 'defx menu', 'ignore_case': 0}
        call quickui#context#open(content, opts)
    endfunction
    augroup DefxGroup
        autocmd!
        autocmd FileType defx setlocal nonumber
        autocmd FileType defx setlocal foldcolumn=0
        autocmd FileType defx map <silent> <buffer> <tab> :call <SID>open_defx_menu()<CR>
        autocmd FileType defx map <silent><buffer> <RightMouse> :call <SID>open_defx_menu()<CR>
        " autocmd BufEnter,VimEnter,BufNew,BufWinEnter,BufRead,BufCreate
        "             \ * if isdirectory(expand('<amatch>'))
        "             \   | call s:browse_check(expand('<amatch>')) | endif

        " function! s:browse_check(path) abort
        "     if bufnr('%') != expand('<abuf>')
        "         return
        "     endif

        "     " Disable netrw.
        "     augroup FileExplorer
        "         autocmd!
        "     augroup END

        "     execute 'Defx' a:path
        " endfunction
    augroup END

    if g:devicons_install == 1
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
endif
