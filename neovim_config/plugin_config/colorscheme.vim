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

highlight ALEErrorSign gui=bold term=bold guibg=NONE guifg=#DB5A6B ctermbg=NONE ctermfg=Red
highlight ALEErrorSignLineNr gui=bold term=bold guibg=NONE guifg=#DB5A6B ctermbg=NONE ctermfg=Red
highlight ALEWarningSign gui=bold term=bold guibg=NONE guifg=#A78E44 ctermbg=NONE ctermfg=Yellow
highlight ALEWarningSignLineNr gui=bold term=bold guibg=NONE guifg=#A78E44 ctermbg=NONE ctermfg=Yellow
highlight ALEError gui=underline term=underline guibg=none guifg=#DB5A6B ctermbg=none ctermfg=Red
highlight ALEWarning gui=underline term=underline guibg=none guifg=#A78E44 ctermbg=none ctermfg=Yellow
