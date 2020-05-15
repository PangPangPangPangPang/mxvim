let g:startify_change_to_vcs_root = 1

let g:my_startify_custom_header = [ 
            \ ' MMMMMMMM               MMMMMMMM                                      ``````                       VVVVVVVV           VVVVVVVV  iiii                          ',
            \ ' M:::::::M             M:::::::M                                      `::::`                       V::::::V           V::::::V i::::i                         ',
            \ ' M::::::::M           M::::::::M                                      `::::`                       V::::::V           V::::::V  iiii                          ',
            \ ' M:::::::::M         M:::::::::M                                      ``:::`                       V::::::V           V::::::V                                ',
            \ ' M::::::::::M       M::::::::::M  aaaaaaaaaaaaa   xxxxxxx      xxxxxxx  `:::`    ssssssssss         V:::::V           V:::::V iiiiiii    mmmmmmm    mmmmmmm   ',
            \ ' M:::::::::::M     M:::::::::::M  a::::::::::::a   x:::::x    x:::::x    ````  ss::::::::::s         V:::::V         V:::::V  i:::::i  mm:::::::m  m:::::::mm ',
            \ ' M:::::::M::::M   M::::M:::::::M  aaaaaaaaa:::::a   x:::::x  x:::::x         ss:::::::::::::s         V:::::V       V:::::V    i::::i m::::::::::mm::::::::::m',
            \ ' M::::::M M::::M M::::M M::::::M           a::::a    x:::::xx:::::x          s::::::ssss:::::s         V:::::V     V:::::V     i::::i m::::::::::::::::::::::m',
            \ ' M::::::M  M::::M::::M  M::::::M    aaaaaaa:::::a     x::::::::::x            s:::::s  ssssss           V:::::V   V:::::V      i::::i m:::::mmm::::::mmm:::::m',
            \ ' M::::::M   M:::::::M   M::::::M  aa::::::::::::a      x::::::::x               s::::::s                 V:::::V V:::::V       i::::i m::::m   m::::m   m::::m',
            \ ' M::::::M    M:::::M    M::::::M a::::aaaa::::::a      x::::::::x                  s::::::s               V:::::V:::::V        i::::i m::::m   m::::m   m::::m',
            \ ' M::::::M     MMMMM     M::::::Ma::::a    a:::::a     x::::::::::x           ssssss   s:::::s              V:::::::::V         i::::i m::::m   m::::m   m::::m',
            \ ' M::::::M               M::::::Ma::::a    a:::::a    x:::::xx:::::x          s:::::ssss::::::s              V:::::::V         i::::::im::::m   m::::m   m::::m',
            \ ' M::::::M               M::::::Ma:::::aaaa::::::a   x:::::x  x:::::x         s::::::::::::::s                V:::::V          i::::::im::::m   m::::m   m::::m',
            \ ' M::::::M               M::::::M a::::::::::aa:::a x:::::x    x:::::x         s:::::::::::ss                  V:::V           i::::::im::::m   m::::m   m::::m',
            \ ' MMMMMMMM               MMMMMMMM  aaaaaaaaaa  aaaaxxxxxxx      xxxxxxx         sssssssssss                     VVV            iiiiiiiimmmmmm   mmmmmm   mmmmmm',
            \ ]
let g:startify_custom_header =
            \ 'startify#center(g:my_startify_custom_header)'

" let g:startify_custom_header = g:ascii + startify#fortune#boxed()
function! s:list_commits()
    let git = 'git -C ~/repo'
    let commits = systemlist(git .' log --oneline | head -n10')
    let git = 'G'. git[1:]
    return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

let g:startify_lists = [
            \ { 'header': ['   MRU'],            'type': 'files' },
            \ { 'header': ['   Sessions'],       'type': 'sessions' },
            \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
            \ { 'header': ['   Commits'],        'type': function('s:list_commits') },
            \ ]
let g:startify_session_persistence = 1
