let g:coc_global_extensions = [
            \'coc-python',
            \'coc-json',
            \'coc-tsserver',
            \'coc-html',
            \'coc-css',
            \'coc-snippets',
            \'coc-vimlsp',
            \'coc-prettier',
            \'coc-translator',
            \'coc-flutter'
            \]

nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-y>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <CR> pumvisible() ? "\<Esc>a\<CR>" : "\<CR>"
let g:coc_snippet_next = '<c-n>'
let g:coc_snippet_prev = '<c-p>'

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
