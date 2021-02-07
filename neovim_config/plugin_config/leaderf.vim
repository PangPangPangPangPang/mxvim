let g:Lf_ShortcutF = '<C-P>'
" let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_PreviewCode = 1
let g:Lf_ShowHidden = 1
let g:Lf_ShortcutB = '<Leader>bo'
let g:Lf_DefaultExternalTool = "rg"
let g:Lf_RootMarkers = ['.xcworkspace', '.project', '.git']
let g:Lf_WindowPosition = 'bottom'
let g:Lf_PreviewInPopup = 1
let g:Lf_PopupColorscheme = 'gruvbox_default'
let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_ShowDevIcons = 0

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
