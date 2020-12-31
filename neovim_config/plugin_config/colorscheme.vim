set background=dark
" set background=light
"     highlight color group
nnoremap <silent> <leader>wh :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" set background=light

" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" 
" colorscheme dracula
" colorscheme hybrid

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

" try 
"     let g:gruvbox_transp_bg = 0
"     let g:gruvbox_plugin_hi_groups = 1
"     let g:gruvbox_filetype_hi_groups = 1
"     colorscheme gruvbox8_soft
" endtry
" let g:dracula_bold = 1
" let g:dracula_italic = 1
" let g:dracula_colorterm = 1
" let g:dracula_inverse = 0
" colorscheme dracula
" colorscheme snazzy

" let g:equinusocio_material_darker = 0
" colorscheme equinusocio_material

autocmd InsertEnter * hi clear CursorLine | hi! link CursorLine None
autocmd InsertLeave * hi clear CursorLine | hi! link CursorLine ColorColumn
" autocmd InsertEnter * hi clear CursorColumn | hi! link CursorColumn None
" autocmd InsertLeave * hi clear CursorColumn | hi! link CursorColumn ColorColumn

let g:miramare_enable_italic = 1
let g:miramare_enable_italic_string = 1
let g:miramare_enable_bold = 1
let g:miramare_disable_italic_comment = 0
let g:miramare_transparent_background = 0
silent! colorscheme miramare
"
" 
" try 
    " if has('gui_running')
    "     let g:gruvbox_material_transparent_background= 0
    " else
    "     let g:gruvbox_material_transparent_background= 1
    " endif
" let g:gruvbox_material_palette = 'original'
" let g:gruvbox_material_background = 'soft'
" let g:gruvbox_material_enable_italic = 1
" let g:gruvbox_material_enable_bold = 1
" let g:gruvbox_material_visual = 'grey background'
" let g:gruvbox_material_sign_column_background = 'none'
" let g:gruvbox_material_italicize_strings = 1
" let g:gruvbox_material_diagnostic_line_highlight = 0
" let g:gruvbox_material_lightline_disable_bold = 0
" let g:gruvbox_material_disable_italic_comment = 0
" let g:gruvbox_material_current_word = 'bold'
" let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_statusline_style = 'original'
" silent! colorscheme gruvbox-material
    " endtry

" let g:gruvbox_italic = 1
" let g:gruvbox_contrast_dark = 'soft'
" colorscheme gruvbox

" colorscheme deus
" try
"     colorscheme forest-night
" endtry
" try
"     colorscheme xcodedark
"     let g:xcodedark_emph_funcs = 1
"     let g:xcodedark_emph_idents = 1
"     augroup vim-colors-xcode
"         autocmd!
"     augroup END
" 
"     autocmd vim-colors-xcode ColorScheme * hi Comment        cterm=italic gui=italic
"     autocmd vim-colors-xcode ColorScheme * hi SpecialComment cterm=italic gui=italic
" endtry

highlight IlluminatedWord gui=none term=none guibg=#444444 guifg=none ctermbg=245 ctermfg=none
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord IlluminatedWord
augroup END
