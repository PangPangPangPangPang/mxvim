if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif

noremap <c-p> :Files<cr>
" noremap <c-p> :CocCommand fzf-preview.ProjectFiles<cr>


let $FZF_DEFAULT_OPTS = '--layout=reverse'
let $FZF_DEFAULT_OPTS .= ' --info=inline'
let $FZF_DEFAULT_OPTS .= ' --tiebreak=end,index'
let $FZF_PREVIEW_COMMAND = 'COLORTERM=truecolor bat --color=always --style=plain --theme=TwoDark -n -- {} || cat {}'
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


" noremap <c-p> :CocCommand fzf-preview.DirectoryFiles<cr>
let g:fzf_preview_floating_window_rate = 0.6
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let g:fzf_preview_lines_command = 'bat --color=always --plain --number'
let g:fzf_preview_use_dev_icons = 1
" augroup fzf_preview
"   autocmd!
"   autocmd User fzf_preview#initialized call s:fzf_preview_settings()
" augroup END
" 
" function! s:fzf_preview_settings() abort
"   let g:fzf_preview_command = 'COLORTERM=truecolor ' . g:fzf_preview_command
"   let g:fzf_preview_grep_preview_cmd = 'COLORTERM=truecolor ' . g:fzf_preview_grep_preview_cmd
" endfunction

