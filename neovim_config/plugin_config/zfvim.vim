function! s:myLocalDb()
    let db = ZFVimIM_dbInit({
                \   'name' : 'YourDb',
                \ })
    call ZFVimIM_cloudRegister({
                \   'mode' : 'local',
                \   'dbId' : db['dbId'],
                \   'repoPath' : '~/.config/nvim', 
                \   'dbFile' : '/pinyin.txt', 
                \ })
endfunction
" autocmd User ZFVimIM_event_OnDbInit call s:myLocalDb()
