
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
call Source('~/.config/nvim/path/path.vim')

" Load plugin
call Source('~/.config/nvim/plug.vim')

" Load basic config
call Source('~/.config/nvim/basic.vim')

