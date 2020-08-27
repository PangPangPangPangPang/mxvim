let g:coc_global_extensions = [
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
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

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
" Remap for rename current word
nmap <leader>ar <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>af  <Plug>(coc-format-selected)
nmap <leader>af  <Plug>(coc-format-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
map <leader>ax  <Plug>(coc-fix-current)
" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Use `:Prettier` to format current buffer.
command! -nargs=0 Prettier :CocCommand prettier.formatFile

map <silent> <leader>t :CocCommand translator.popup<CR>

" For flutter
augroup Flutter
    autocmd FileType dart nnoremap <silent> <buffer> <leader>fs :CocCommand flutter.run --dart-define=runInFlutter=true<cr>
    autocmd FileType dart nnoremap <silent> <buffer> <leader>fa :CocCommand flutter.attach<cr>
    autocmd FileType dart nnoremap <silent> <buffer> <leader>fq :CocCommand flutter.dev.quit<cr>
    autocmd FileType dart nnoremap <silent> <buffer> <leader>fr :CocCommand flutter.dev.hotreload<cr>
    autocmd FileType dart nnoremap <silent> <buffer> <leader>fR :CocCommand flutter.dev.hotRestart<cr>
    autocmd FileType dart nnoremap <silent> <buffer> <leader>fl :CocCommand flutter.dev.openDevLog<cr>
    autocmd FileType dart nnoremap <silent> <buffer> <leader>fp :CocCommand flutter.dev.openProfiler<cr>
    autocmd FileType dart nnoremap <silent> <buffer> <F2> :CocCommand flutter.toggleOutline<cr>
augroup end

augroup Coc
    augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

