if !exists('g:mx_loaded_nerdtree')
    finish
endif
let NERDTreeIgnore=['\.pyc$', '\~$']
map <silent> <F1> :NERDTreeToggle<cr>
map <silent> <leader>j :NERDTreeFind<cr>
