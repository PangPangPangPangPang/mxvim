let g:Lf_ShortcutF = '<C-P>'
let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_PreviewCode = 1
let g:Lf_ShowHidden = 1
let g:Lf_StlColorscheme = 'one'
let g:Lf_ShortcutB = '<Leader>bo'
let g:Lf_DefaultExternalTool = "rg"
let g:Lf_RootMarkers = ['.xcworkspace', '.project', '.git']
" let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1

" let g:Lf_UseVersionControlTool = "git ls-files"
let g:Lf_CommandMap = {'<C-C>': ['<Esc>', '<C-C>'],
            \ '<C-J>': ['<C-N>', '<C-J>'],
            \ '<C-K>': ['<C-P>', '<C-K>'],
            \ '<C-]>': ['<C-V>'],
            \ '<C-X>': ['<C-S>'],
            \ '<C-P>': ['<C-O>'],
            \}
let g:Lf_WindowHeight = 0.3
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_ReverseOrder = 1
function! s:set_leaderf_highlights()                                                                                                                                                                       
    highlight link Lf_hl_cursorline Cursorline                                                                                                                                                             
    highlight link Lf_hl_popup_inputText LightlineLeft_inactive_0                                                                                                                                          
    highlight link Lf_hl_popup_blank LightlineLeft_inactive_0                                                                                                                                              
    highlight link Lf_hl_popup_window Pmenu                                                                                                                                                                
    highlight link Lf_hl_popup_normalMode LightlineLeft_normal_0                                                                                                                                           
    highlight link Lf_hl_popup_inputMode LightlineLeft_insert_0                                                                                                                                            
    highlight link Lf_hl_popup_lineInfo LightlineRight_active_1                                                                                                                                            
    highlight link Lf_hl_popup_total LightlineRight_active_0                                                                                                                                               
    highlight link Lf_hl_popup_category LightlineLeft_normal_0                                                                                                                                             
    highlight link Lf_hl_popup_nameOnlyMode LightlineLeft_normal_1                                                                                                                                         
    highlight link Lf_hl_popup_fullPathMode LightlineLeft_normal_1                                                                                                                                         
    highlight link Lf_hl_popup_fuzzyMode LightlineLeft_normal_1                                                                                                                                            
    highlight link Lf_hl_popup_regexMode LightlineLeft_normal_1                                                                                                                                            
    highlight link Lf_hl_popup_cwd LightlineRight_normal_2                                                                                                                                                 
    highlight link Lf_hl_match Search                                                                                                                                                                      
endfunction
