
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif

let g:mapleader = "\<space>"

function! Source(path)
   if !empty(glob(a:path))
       exec ('source '. a:path)
   endif
endfunction

" Load plugin
call Source('~/.config/nvim/plug.vim')
for f in split(glob('~/.config/nvim/path/path.vim'))
    exec 'source' f
endfor

" Load basic config
call Source('~/.config/nvim/basic.vim')

