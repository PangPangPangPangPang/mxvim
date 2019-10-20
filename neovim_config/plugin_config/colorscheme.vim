syntax enable
set background=dark

" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" let g:srcery_italic = 1
" let g:srcery_transparent_background = 1
" let g:srcery_inverse_matches = 1
" let g:srcery_inverse_match_paren = 1
" colorscheme srcery

let g:PaperColor_Theme_Options = {
            \   'theme': {
            \     'default': {
            \       'transparent_background': 1
            \     }
            \   }
            \ }
colorscheme PaperColor

" let g:one_allow_italics = 1
" colorscheme one

" highlight Normal ctermbg=None
" let g:grubox_italic = 1
" let g:grubox_contrast = 'hard'
" colorscheme gruvbox
