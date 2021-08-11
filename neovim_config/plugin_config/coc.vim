if !g:use_coc
    finish
endif

let g:coc_global_extensions = [
            \'coc-actions',
            \'coc-python',
            \'coc-sh',
            \'coc-json',
            \'coc-tsserver',
            \'coc-react-refactor',
            \'coc-prettier',
            \'coc-eslint',
            \'coc-stylelint',
            \'coc-html',
            \'coc-css',
            \'coc-snippets',
            \'coc-vimlsp',
            \'coc-translator',
            \'coc-flutter',
            \'coc-sourcekit',
            \'coc-postfix',
            \'coc-fzf-preview',
            \'coc-lua',
            \'coc-stylelintplus',
            \'coc-spell-checker',
            \]
" \'coc-flutter-tools',
" \'coc-highlight',
" \'coc-explorer',
" \'coc-fzf-preview',

" nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> <c-]> :call <SID>GotoDefinition()<CR>
nmap <silent> <Esc> :call coc#float#close_all() <CR>

function! s:GotoDefinition() abort
    let l:current_tag = expand('<cWORD>')

    let l:current_position    = getcurpos()
    let l:current_position[0] = bufnr()

    let l:current_tag_stack = gettagstack()
    let l:current_tag_index = l:current_tag_stack['curidx']
    let l:current_tag_items = l:current_tag_stack['items']

    if CocAction('jumpDefinition')
        let l:new_tag_index = l:current_tag_index + 1
        let l:new_tag_item  = [#{tagname: l:current_tag, from: l:current_position}]
        let l:new_tag_items = l:current_tag_items[:]
        if l:current_tag_index <= len(l:current_tag_items)
            call remove(l:new_tag_items, l:current_tag_index - 1, -1)
        endif
        let l:new_tag_items += l:new_tag_item

        call settagstack(winnr(), #{curidx: l:new_tag_index, items: l:new_tag_items}, 'r')
    endif
endfunction

if exists('+tagfunc') | setlocal tagfunc=CocTagFunc | endif

" map <silent> <F1> :CocCommand explorer<CR>
" map <silent> <leader>j :CocCommand explorer --no-toggle<CR>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
"
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " autocmd bufenter * call s:coc_highlight()
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
                \ ["Code &Prettier", "Neoformat" ],
                \ ["Close F&loat", "call coc#util#close_floats()"]
                \ ]
    " \ ["Code &Prettier", "CocCommand prettier.formatFile" ],
    " set cursor to the last position
    let opts = {'index':g:quickui#context#cursor}
    call quickui#context#open(content, opts)
endfunction
nmap <silent> <leader>c :call <SID>open_coc_menu()<CR>

" Visual Menu config
function s:open_coc_visual_menu() abort
    let content = [
                \ ["&Format Code", "call CocActionAsync('formatSelected', visualmode())" ],
                \ ["Fi&x Code", "call CocActionAsync('doQuickfix')"],
                \ ['-'],
                \ ["&Code Aciton", "CocCommand actions.open" ],
                \ ['-'],
                \ ["Code &Prettier", "Neoformat" ],
                \ ["Close F&loat", "call coc#util#close_floats()"]
                \ ]
    " \ ["Code &Prettier", "CocCommand prettier.formatFile" ],
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
                \ ["Open &Profiler", "CocCommand flutter.dev.openDevToolsProfiler"],
                \ ["Toggle &Outline", "CocCommand flutter.toggleOutline"],
                \ ['-'],
                \ ["&Find all", "Grepper"],
                \ ]
    " \ ["Open Dev&Log", "CocCommand flutter.dev.openDevLog"],
    " set cursor to the last position
    let opts = {'index':g:quickui#context#cursor}
    call quickui#context#open(content, opts)
endfunction
vmap <silent> <leader>f :call <SID>open_coc_flutter_menu()<CR>

augroup Flutter
    autocmd FileType dart nnoremap <silent> <leader>f :call <SID>open_coc_flutter_menu()<CR>
augroup end

function s:coc_highlight() abort
    hi default link CocErrorVirtualText LineNr
    hi default link CocWarningVirtualText LineNr
    hi default link CocInfoVirtualText LineNr
    hi default link CocHintVirtualText LineNr
    hi default link CocErrorSign ErrorMsg
    hi default link CocWarningSign WarningMsg
    hi default link CocInfoSign Question
    " hi default link CocFloating Normal
    hi! CocUnderline gui=undercurl term=undercurl guisp=#c4384b
    hi! CocErrorHighlight gui=undercurl term=undercurl guisp=#c4384b
    hi! CocInfoHighlight gui=undercurl term=undercurl guisp=#c4ab39
    hi! CocWarningHighlight gui=undercurl term=undercurl guisp=#c4ab39
endfunction
call s:coc_highlight()
