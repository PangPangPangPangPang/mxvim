let g:lightline = {
            \ 'active':{},
            \ 'inactive':{},
            \ }

" let g:lightline.active.right = [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'cocstatus'], [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ]]
let g:lightline.active.right = [[ 'gitbranch' ], [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ]]
let g:lightline.active.left = [[ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ]]
let g:lightline.inactive.left = [[ 'filename' ]]
let g:lightline.inactive.right = []
let g:lightline.tab = {
            \ 'active': [ 'tabnum', 'filename', 'modified' ],
            \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

let g:lightline.tabline = {
            \ 'left': [ [ 'tabs' ] ],
            \ 'right': [ [ 'close' ] ] }
let g:lightline.component_function = {
            \ 'gitbranch': 'fugitive#head',
            \ 'cocstatus': 'coc#status',
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
            \}
" let g:lightline.colorscheme = 'srcery'
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '┃', 'right': '┃' }
let g:lightline.component_expand = {
            \  'linter_checking': 'lightline#ale#checking',
            \  'linter_warnings': 'lightline#ale#warnings',
            \  'linter_errors': 'lightline#ale#errors',
            \  'linter_ok': 'lightline#ale#ok',
            \ }
let g:lightline.component_type = {
            \     'linter_checking': 'left',
            \     'linter_warnings': 'warning',
            \     'linter_errors': 'error',
            \     'linter_ok': 'left',
            \ }

function! LightlinePercent()
    if &ft =~ 'defx'
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
    return &ft =~ 'help\|vimfiler\|gundo\|defx' ? '' : &modified ? 'modified' : &modifiable ? '' : ''
endfunction

function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo\|defx' && &readonly ? '' : ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname =~ '\[defx\]' ? 'defx' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineFilename()
    return &ft =~ 'help\|vimfiler\|gundo\|defx' ? '' : expand('%:t')
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction
