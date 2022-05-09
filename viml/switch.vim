function! s:mx_switch_in_window()
    call <SID>mx_switch_use_jump("find ")
endfunction

function! s:mx_switch_split()
    call <SID>mx_switch_use_jump(":vsp ")
endfunction

function! s:mx_switch_use_jump(jump) 
    let s:jump = a:jump
    if match(expand("%"),'\.m') > 0
        let s:filename = substitute(expand("%"),'\.m\(.*\)','.h\1',"")
        exe s:jump s:filename
    elseif match(expand("%"),"\\.h") > 0
        if filereadable(substitute(expand("%"),'\.h\(.*\)','.m\1',""))
            exe s:jump . substitute(expand("%"),'\.h\(.*\)','.m\1',"")
        elseif filereadable(substitute(expand("%"),'\.h\(.*\)','.c\1',""))
            exe s:jump . filereadable(substitute(expand("%"),'\.h\(.*\)','.c\1',""))
        elseif filereadable(substitute(expand("%"),'\.h\(.*\)','.cpp\1',""))
            exe s:jump . filereadable(substitute(expand("%"),'\.h\(.*\)','.cpp\1',""))
        endif
    elseif match(expand("%"),"\\.js") > 0
        if filereadable(substitute(expand("%"),'\.js\(.*\)','.html\1',""))
            exe s:jump . substitute(expand("%"),'\.js\(.*\)','.html\1',"")
        elseif filereadable(substitute(expand("%"),'\.js\(.*\)','.css\1',""))
            exe s:jump . substitute(expand("%"),'\.js\(.*\)','.css\1',"")
        elseif filereadable(substitute(expand("%"),'\.js\(.*\)','.ttml\1',""))
            exe s:jump . substitute(expand("%"),'\.js\(.*\)','.ttml\1',"")
        elseif filereadable(substitute(expand("%"),'\.js\(.*\)','.ttss\1',""))
            exe s:jump . substitute(expand("%"),'\.js\(.*\)','.ttss\1',"")
        endif
    elseif match(expand("%"),"\\.html") > 0
        if filereadable(substitute(expand("%"),'\.html\(.*\)','.css\1',""))
            exe s:jump . substitute(expand("%"),'\.html\(.*\)','.css\1',"")
        elseif filereadable(substitute(expand("%"),'\.html\(.*\)','.js\1',""))
            exe s:jump . substitute(expand("%"),'\.html\(.*\)','.js\1',"")
        endif
    elseif match(expand("%"),"\\.css") > 0
        if filereadable(substitute(expand("%"),'\.css\(.*\)','.js\1',""))
            exe s:jump . substitute(expand("%"),'\.css\(.*\)','.js\1',"")
        elseif filereadable(substitute(expand("%"),'\.css\(.*\)','.html\1',""))
            exe s:jump . substitute(expand("%"),'\.css\(.*\)','.html\1',"")
        endif
    elseif match(expand("%"),"\\.ttml") > 0
        if filereadable(substitute(expand("%"),'\.ttml\(.*\)','.ttss\1',""))
            exe s:jump . substitute(expand("%"),'\.ttml\(.*\)','.ttss\1',"")
        elseif filereadable(substitute(expand("%"),'\.ttml\(.*\)','.js\1',""))
            exe s:jump . substitute(expand("%"),'\.ttml\(.*\)','.js\1',"")
        endif
    elseif match(expand("%"),"\\.ttss") > 0
        if filereadable(substitute(expand("%"),'\.ttss\(.*\)','.js\1',""))
            exe s:jump . substitute(expand("%"),'\.ttss\(.*\)','.js\1',"")
        elseif filereadable(substitute(expand("%"),'\.ttss\(.*\)','.ttml\1',""))
            exe s:jump . substitute(expand("%"),'\.ttss\(.*\)','.ttml\1',"")
        endif
    endif
endfunction

command! -nargs=0 -bar A :call <SID>mx_switch_in_window()<CR>
nnoremap <silent><leader><up> :call <SID>mx_switch_in_window()<CR>
nnoremap <silent><leader><down> :call <SID>mx_switch_split()<CR>

function! GetVisualSelection(type) abort
  let regsave = @@
  let selsave = &selection
  let &selection = 'inclusive'

  if a:type =~? 'v'
    silent execute "normal! gvy"
  elseif a:type == 'line'
    silent execute "normal! '[V']y"
  else
    silent execute "normal! `[v`]y"
  endif

  let &selection = selsave
  let ret = @@
  let @@ = regsave
  return escape(ret, ' \^$.*+?()[]{}|')
endfunction
