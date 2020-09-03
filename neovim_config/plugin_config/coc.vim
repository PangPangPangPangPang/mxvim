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

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

map <silent> <leader>t :CocCommand translator.popup<CR>


augroup Coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Normal Menu config
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
        \ ["&Format Code", "call CocActionAsync('format')" ],
        \ ["Fi&x Code", "call CocActionAsync('doQuickfix')"],
        \ ["&Code Aciton", "CocCommand actions.open" ],
        \ ['-'],
        \ ["Code &Prettier", "CocCommand prettier.formatFile" ],
        \ ["Code &Prettier", "CocCommand prettier.formatFile" ],
        \ ]
  " set cursor to the last position
  let opts = {'index':g:quickui#context#cursor}
  call quickui#context#open(content, opts)
endfunction
nmap <leader>c :call <SID>open_coc_menu()<CR>

" Visual Menu config
function s:open_coc_visual_menu() abort
  let content = [
        \ ["&Format Code", "call CocActionAsync('formatSelected', visualmode())" ],
        \ ["Fi&x Code", "call CocActionAsync('doQuickfix')"],
        \ ['-'],
        \ ["&Code Aciton", "CocCommand actions.open" ],
        \ ['-'],
        \ ["Code &Prettier", "CocCommand prettier.formatFile" ],
        \ ]
  " set cursor to the last position
  let opts = {'index':g:quickui#context#cursor}
  call quickui#context#open(content, opts)
endfunction
vmap <leader>c :call <SID>open_coc_visual_menu()<CR>

" For flutter
function s:open_coc_flutter_menu() abort
  let content = [
        \ ["&Attach", "CocCommand flutter.attach" ],
        \ ["Attach &Simple", "CocCommand flutter.attach --dart-define=runInFlutter=true"],
        \ ["&Quit Debug", "CocCommand flutter.dev.quit" ],
        \ ['-'],
        \ ["Hot &Reload", "CocCommand flutter.dev.hotReload"],
        \ ["&Hot Restart", "CocCommand flutter.dev.hotRestart"],
        \ ['-'],
        \ ["Open Dev&Log", "CocCommand flutter.dev.openDevLog"],
        \ ["Open &Profiler", "CocCommand flutter.dev.openProfiler"],
        \ ["Toggle &Outline", "CocCommand flutter.toggleOutline"],
        \ ['-'],
        \ ["&Find all", "Grepper"],
        \ ]
  " set cursor to the last position
  let opts = {'index':g:quickui#context#cursor}
  call quickui#context#open(content, opts)
endfunction
vmap <leader>f :call <SID>open_coc_flutter_menu()<CR>

augroup Flutter
  autocmd FileType dart nnoremap <silent> <leader>f :call <SID>open_coc_flutter_menu()<CR>
augroup end
