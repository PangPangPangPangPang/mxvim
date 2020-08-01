if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif

noremap <c-p> :Files<cr>
let $FZF_DEFAULT_OPTS = '--layout=reverse'
let $FZF_DEFAULT_OPTS .= ' --info=inline'
let $FZF_DEFAULT_OPTS .= ' --tiebreak=end,index'
let $FZF_PREVIEW_COMMAND = 'bat --color=always --style=plain --theme=TwoDark -n -- {} || cat {}'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'border': 'rounded' } }


function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction
let g:fzf_action = {
            \ 'ctrl-l': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }
