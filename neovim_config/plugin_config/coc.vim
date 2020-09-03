let g:coc_global_extensions = [
            \'coc-actions',
            \'coc-python',
            \'coc-sh',
            \'coc-imselect',
            \'coc-json',
            \'coc-tsserver',
            \'coc-html',
            \'coc-css',
            \'coc-snippets',
            \'coc-vimlsp',
            \'coc-prettier',
            \'coc-translator',
            \'coc-flutter-tools',
            \'coc-sourcekit',
            \'coc-postfix',
            \'coc-fzf-preview',
            \]

nmap <silent> <c-]> <Plug>(coc-definition)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Remap for format selected region
"
function s:open_coc_menu() abort
let content = [
                \ ["Find &Type Definition", "call CocActionAsync('jumpDefinition')" ],
                \ ["Find &Implementation", "call CocActionAsync('jumpImplementation')" ],
                \ ["Find &References", "call CocActionAsync('jumpReferences')" ],
                \ ['-'],
                \ ["Prev Diagnostic &[", "call CocActionAsync('diagnosticPrevious')" ],
                \ ["Next Diagnostic &]", "call CocActionAsync('diagnosticNext')" ],
                \ ['-'],
                \ ["Re&name", "call CocActionAsync('rename')"],
                \ ["&Format Code", "call CocActionAsync('formatSelected', '')" ],
                \ ["Fi&x Code", "call CocAction('doQuickFix')"],
                \ ["&CodeAciton", "call CocActionAsync('codeAction', '')" ],
                \ ]
    " set cursor to the last position
    let opts = {'index':g:quickui#context#cursor}
    call quickui#context#open(content, opts)
endfunction
nmap <leader>c :call <SID>open_coc_menu()<CR>
function s:open_coc_visual_menu() abort
let content = [
                \ ["&Format Code", "call CocActionAsync('formatSelected', visualmode())" ],
                \ ["Fi&x Code", "call CocAction('doQuickFix')"],
                \ ['-'],
                \ ["&CodeAciton", "call CocActionAsync('codeAction', visualmode())" ],
                \ ["&Rename", "call CocActionAsync('rename')"],
                \ ]
    " set cursor to the last position
    let opts = {'index':g:quickui#context#cursor}
    call quickui#context#open(content, opts)
endfunction
vmap <leader>c :call <SID>open_coc_visual_menu()<CR>
" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Use `:Prettier` to format current buffer.
command! -nargs=0 Prettier :CocCommand prettier.formatFile

map <silent> <leader>t :CocCommand translator.popup<CR>

" For flutter
augroup Flutter
    autocmd FileType dart nnoremap <silent> <leader>fs :CocCommand flutter.attach --dart-define=runInFlutter=true <cr>
    autocmd FileType dart nnoremap <silent> <leader>fa :CocCommand flutter.attach<cr>
    autocmd FileType dart nnoremap <silent> <leader>fq :CocCommand flutter.dev.quit<cr>
    autocmd FileType dart nnoremap <silent> <leader>fr :CocCommand flutter.dev.hotReload<cr>
    autocmd FileType dart nnoremap <silent> <leader>fR :CocCommand flutter.dev.hotRestart<cr>
    autocmd FileType dart nnoremap <silent> <leader>fl :CocCommand flutter.dev.openDevLog<cr>
    autocmd FileType dart nnoremap <silent> <leader>fp :CocCommand flutter.dev.openProfiler<cr>
    autocmd FileType dart nnoremap <silent> <F2> :CocCommand flutter.toggleOutline<cr>
augroup end

augroup Coc
    augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

