set runtimepath^=~/.config/nvim/after

if get(s:, 'loaded', 0) != 0
	finish



else
	let s:loaded = 1
endif

let g:mapleader = "\<space>"

function! s:Source(path)
   if !empty(glob(a:path))
       exec ('source '. a:path)
   endif
endfunction
call <SID>Source('~/.config/nvim/path/path.vim')

" Load plugin
call <SID>Source('~/.config/nvim/plug.vim')

" Load basic config
call <SID>Source('~/.config/nvim/basic.vim')

" Load private config
call <SID>Source('~/.config/nvim/private.vim')


