set background=dark
" set background=light

" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" let g:srcery_italic = 1
" let g:srcery_bold = 1
" let g:srcery_transparent_background = 1
" let g:srcery_inverse_matches = 1
" let g:srcery_inverse_match_paren = 1
" colorscheme srcery

" let g:PaperColor_Theme_Options = {
"             \   'theme': {
"             \     'default.dark': {
"             \       'transparent_background': 1,
"             \       'allow_bold': 1,
"             \       'allow_italic': 1
"             \     }
"             \   }
"             \ }
" colorscheme PaperColor


" let g:one_allow_italics = 1
" colorscheme one

" highlight Normal ctermbg=None
let g:gruvbox_italic = 1
let g:gruvbox_bold = 1
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_number_column = 'bg0'
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_transparent_bg=1
" colorscheme gruvbox
" colorscheme dracula
" colorscheme hybrid
"
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_italicize_strings = 1
let g:gruvbox_material_disable_italic_comment = 0
let g:gruvbox_material_transparent_background= 1
let g:gruvbox_material_lightline_disable_bold = 0
let g:Lf_StlColorscheme = 'gruvbox_material'

colorscheme gruvbox-material
if has('nvim')
    highlight CursorLineNr gui=bold term=bold guibg=NONE guifg=#D79921 ctermbg=NONE ctermfg=Yellow
    highlight LineNr gui=NONE term=NONE guibg=NONE guifg=#928374 ctermbg=NONE ctermfg=Gray
    highlight SignColumn gui=NONE term=NONE guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE

    highlight GitGutterAdd gui=BOLD term=BOLD guibg=NONE guifg=#AFDD22 ctermbg=NONE ctermfg=Green
    highlight GitGutterChange gui=BOLD term=BOLD guibg=NONE guifg=#fff143 ctermbg=NONE ctermfg=Yellow
    highlight GitGutterDelete gui=BOLD term=BOLD guibg=NONE guifg=#DB5A6B ctermbg=NONE ctermfg=Red
    highlight GitGutterChangeDelete gui=BOLD term=BOLD guibg=NONE guifg=#DB5A6B ctermbg=NONE ctermfg=Red
endif
highlight ALEErrorSign gui=bold term=bold guibg=NONE guifg=#DB5A6B ctermbg=NONE ctermfg=Red
highlight ALEErrorSignLineNr gui=bold term=bold guibg=NONE guifg=#DB5A6B ctermbg=NONE ctermfg=Red
highlight ALEWarningSign gui=bold term=bold guibg=NONE guifg=#A78E44 ctermbg=NONE ctermfg=Yellow
highlight ALEWarningSignLineNr gui=bold term=bold guibg=NONE guifg=#A78E44 ctermbg=NONE ctermfg=Yellow
" highlight ALEError gui=underline term=underline guibg=NONE guifg=#DB5A6B ctermbg=NONE ctermfg=Red
" highlight ALEWarning gui=underline term=underline guibg=NONE guifg=#A78E44 ctermbg=NONE ctermfg=Yellow
"
" highlight GitGutterAdd guibg=NONE
" highlight GitGutterChange guibg=NONE
