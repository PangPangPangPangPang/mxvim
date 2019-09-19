let g:lightline = {
            \ 'active':{},
            \ 'inactive':{},
            \ }

let g:lightline.active.right = [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ], [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ]]
let g:lightline.active.left = [[ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ]]
let g:lightline.inactive.left = [[ 'filename' ]]
let g:lightline.inactive.right = []
let g:lightline.component_function = {
            \ 'cocstatus': 'coc#status',
            \ 'modified': 'LightlineModified',
            \ 'readonly': 'LightlineReadonly',
            \ 'filename': 'LightlineFilename',
            \ 'fileformat': 'LightlineFileformat',
            \ 'filetype': 'LightlineFiletype',
            \ 'fileencoding': 'LightlineFileencoding',
            \ 'mode': 'LightlineMode',
            \}
let g:lightline.colorscheme = 'srcery'
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
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

function! LightlineModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname =~ 'defx' ? 'defx' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineFilename()
    let fname = expand('%:t')
    if fname == 'ControlP'
        return ''
    endif
    if fname =~ 'defx'
        return 'defx'
    endif
    if fname =~ 'FZF'
        return 'FZF'
    endif
    if fname =~ '__Tagbar__'
        return 'Tagbar'
    endif

    return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
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



