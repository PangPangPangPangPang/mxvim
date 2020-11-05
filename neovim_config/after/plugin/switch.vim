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
    endif
endfunction

command! -nargs=0 -bar A :call <SID>mx_switch_in_window()<CR>
nnoremap <silent><leader><up> :call <SID>mx_switch_in_window()<CR>
nnoremap <silent><leader><down> :call <SID>mx_switch_split()<CR>

