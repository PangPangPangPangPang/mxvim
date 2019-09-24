if has('python3')
    finish
endif
let NERDTreeIgnore=['\.pyc$', '\~$']
map <silent> <F1> :NERDTreeToggle<cr>
map <silent> <leader>j :NERDTreeFind<cr>
