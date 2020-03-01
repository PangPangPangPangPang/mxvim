function! s:BDExt(ext)
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ "\.'.a:ext.'$"')
  if empty(buffers) |throw "no *.".a:ext." buffer" | endif
  exe 'bd '.join(buffers, ' ')
endfunction
command! -nargs=1 BDExt :call s:BDExt(<f-args>)

noremap <silent><leader>q :cclose<cr> :pclose<cr>
