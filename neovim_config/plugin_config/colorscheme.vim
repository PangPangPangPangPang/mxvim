set background=dark
" set background=light

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
            \     'default.dark': {
            \       'transparent_background': 1,
            \       'allow_bold': 1,
            \       'allow_italic': 1
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

highlight ALEErrorSign guibg=NONE guifg=Red ctermbg=NONE ctermfg=Red
highlight ALEErrorSignLineNr guibg=NONE guifg=Red ctermbg=NONE ctermfg=Red
highlight ALEWarningSign guibg=NONE guifg=Cyan ctermbg=NONE ctermfg=Cyan
highlight ALEWarningSignLineNr guibg=NONE guifg=Cyan ctermbg=NONE ctermfg=Cyan
