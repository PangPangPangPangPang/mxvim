if !Installed("defx.nvim")
    let NERDTreeIgnore=['\.pyc$', '\~$']
    let NERDTreeMinimalUI=1
    let NERDTreeMinimalMenu=0
    let NERDTreeHighlightCursorline = 0
    let g:webdevicons_enable_nerdtree = g:devicons_install
    map <silent> <F1> :NERDTreeToggle<cr>
    map <silent> <leader>j :NERDTreeFind<cr>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif
