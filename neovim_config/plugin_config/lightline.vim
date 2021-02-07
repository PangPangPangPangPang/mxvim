" let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#enable_devicons = g:devicons_install

let g:lightline = {
            \ 'active':{},
            \ 'inactive':{},
            \ }

let g:lightline.active.right = [[ 'fileformat', 'fileencoding', 'filetype' ], [ 'percent' ], [ 'lineinfo' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]]
let g:lightline.active.left = [[ 'mode', 'paste' ], [ 'gitbranch' ],  [ 'readonly', 'filename', 'modified', 'cocstatus' ]]
let g:lightline.inactive.left = [[ 'filename' ]]
let g:lightline.inactive.right = [['lineinfo']]
let g:lightline.tab = {
            \ 'active': [ 'tabnum', 'filename', 'modified' ],
            \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

let g:lightline.enable = {
            \ 'tabline': 1,
            \}
let g:lightline.tabline = {
            \ 'left': [ [ 'wraptab' ] ],
            \ 'right': [ [ 'max' ] ] }
let g:lightline.component_function = {
            \ 'gitbranch': 'LightlineGitBranch',
            \ 'modified': 'LightlineModified',
            \ 'readonly': 'LightlineReadonly',
            \ 'filename': 'LightlineFilename',
            \ 'fileformat': 'LightlineFileformat',
            \ 'filetype': 'LightlineFiletype',
            \ 'fileencoding': 'LightlineFileencoding',
            \ 'mode': 'LightlineMode',
            \ 'percent': 'LightlinePercent',
            \'charvaluehex': 'LightlineCharValueHex',
            \'lineinfo': 'LightlineLineInfo',
            \'max': 'LightlineTabName',
            \ 'cocstatus': 'LightlineCocStatus',
            \}
" let g:lightline.colorscheme = 'srcery'
" let g:lightline.colorscheme = 'deus'
" let g:lightline.colorscheme = 'forest_night'
" let g:lightline.colorscheme = 'one'
" let g:lightline.colorscheme = 'equinusocio_material'
" let g:lightline.colorscheme = 'gruvbox_material'
" let g:lightline.colorscheme = 'gruvbox8'
" let g:lightline.colorscheme = 'dracula'

let g:lightline.colorscheme = 'miramare'
" let g:lightline.colorscheme = 'snazzy'
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
 
let g:lightline.separator = { 'left': "\uE0B0", 'right': "\uE0B2" }
let g:lightline.subseparator = { 'left': "\uE0B1", 'right': "\uE0B3" }
let g:lightline.tabline_separator = { 'left': "\uE0B0", 'right': "\uE0B2" }
let g:lightline.tabline_subseparator = { 'left': "\uE0B1", 'right': "\uE0B3" }

" let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
" let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
" let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
" let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
" 
let g:lightline#ale#indicator_checking = " "
let g:lightline#ale#indicator_infos = " "
let g:lightline#ale#indicator_warnings = " "
let g:lightline#ale#indicator_errors = " "
let g:lightline#ale#indicator_ok = " "

let g:lightline.component_expand = {
            \  'linter_checking': 'lightline#ale#checking',
            \  'linter_warnings': 'lightline#ale#warnings',
            \  'linter_errors': 'lightline#ale#errors',
            \  'linter_infos': 'lightline#ale#infos',
            \  'linter_ok': 'lightline#ale#ok',
            \  'wraptab': 'LightlineWrapTab',
            \ }
let g:lightline.component_type = {
            \     'linter_checking': 'right',
            \     'linter_warnings': 'warning',
            \     'linter_errors': 'error',
            \     'linter_ok': 'right',
            \     'linter_infos': 'right',
            \     'wraptab': 'tabsel',
            \ }

function LightlineWrapTab()
    if tabpagenr('$') > 1
        return lightline#tabs()
    endif
    let ret = lightline#bufferline#buffers()
    return l:ret
endfunction

function! LightlineTabName()
    return "Max"
endfunction
    
function! LightlinePercent()
    if &ft =~ 'defx' || &ft =~ 'explorer'
        return ''
    endif
    let byte = line2byte( line( "." ) ) + col( "." )
    let size = line2byte( line( "$" ) )
    return (byte * 100) / size . "%"
endfunction

function! LightlineCharValueHex()
    return winwidth(0) > 50 ? printf('%02x', char2nr(getline('.')[col('.')-1])) : ''
endfunction

function! LightlineLineInfo()
    return winwidth(0) > 50 ? printf('%d:%-2d', line('.'), col('.')) : ''
endfunction

function! LightlineModified()
    return &ft =~ 'help\|vimfiler\|gundo\|defx\|explorer' ? '' : &modified ? 'modified' : &modifiable ? '' : ''
endfunction

function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo\|defx\|explorer' && &readonly ? '' : ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname =~ '\[defx\]' ? 'defx' :
                \ fname =~ '\[coc-explorer\]' ? 'Explorer' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" function! LightlineFilename()
"     return &ft =~ 'help\|vimfiler\|gundo\|defx\|explorer' ? '' : expand('%:t')
" endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! LightlineFileformat()
      return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbolWithDefault()) : ''
    " return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineGitBranch()

    if &ft =~ 'defx' || &ft =~ 'explorer'
        return ''
    endif
    return fugitive#Head()
endfunction

function! LightlineCocStatus()

    if &ft =~ 'defx' || &ft =~ 'explorer'
        return ''
    endif
    return coc#status()
endfunction

function! LightlineFiletype()
      return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbolWithDefault() : 'no ft') : ''
    " return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! WebDevIconsGetFileFormatSymbolWithDefault()
    return g:devicons_install ? WebDevIconsGetFileFormatSymbol() : ''
endfunction

function! WebDevIconsGetFileTypeSymbolWithDefault()
    return g:devicons_install ? WebDevIconsGetFileTypeSymbol() : ''
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
