if !exists('g:mx_loaded_nerdtree')
    finish
endif
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeMinimalUI=1
let NERDTreeMinimalMenu=0
map <silent> <F1> :NERDTreeToggle<cr>
map <silent> <leader>j :NERDTreeFind<cr>
