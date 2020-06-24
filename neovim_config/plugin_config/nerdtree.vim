if !Installed("nerdtree")
    finish
endif
echom Installed("nerdtree")
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeMinimalUI=1
let NERDTreeMinimalMenu=0
map <silent> <F1> :NERDTreeToggle<cr>
map <silent> <leader>j :NERDTreeFind<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
