""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Normal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mapleader = "\<space>"

" Sets how many lines of history VIM has to remember
set history=500

" Show line numbers
set nu!

if has('gui_running')
    " Show relative line number
    set relativenumber
endif

" Allow use system clipboard
" set clipboard=unnamed

" Set to auto read when a file is changed from the outside
set autoread


" Search down into subfolders
set path+=**

" Search tags 
set tags=./tags;$HOME

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set 3 lines to the cursor - when moving vertically using j/k
set so=3

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left, change 0 to 1.
set foldcolumn=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" set shiftwidth=4
" set tabstop=4

" 1 tab == 4 spaces
autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp set shiftwidth=4
autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp set tabstop=4
autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp set sts=4
autocmd FileType javascript,html,css,xml,dart,objc set shiftwidth=2
autocmd FileType javascript,html,css,xml,dart,objc set tabstop=2
autocmd FileType javascript,html,css,xml,dart,objc set sts=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
" map <Leader>bo :set nomore<cr>:ls<Bar>:set more<cr>:b<Space>

" Quick create new buffer in the current path.
map <leader>be :e <c-r>=expand("%:p:h")<cr>/

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
    set switchbuf=useopen,usetab 
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Close quickfix window
map <leader>q :cclose<cr> :pclose<cr>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
    nmap ∆ <M-j>
    nmap ˚ <M-k>
    vmap ∆ <M-j>
    vmap ˚ <M-k>
endif

" Delete trailing white space on save, useful for Python and JavaScript.
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()

" Whole format
nnoremap <leader>== mzG=gg`z

" Copy without blank line
map Y $v^y

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" <C-c> press easier then <Esc>, but <C-c> may stop the current task, so use <M-c> instead it.
noremap <C-c> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

if has("mac") || has("macunix")
    noremap ç <C-c>
    inoremap ç <C-c>
    vnoremap ç <C-c>
else
    noremap <M-c> <C-c>
    inoremap <M-c> <C-c>
    vnoremap <M-c> <C-c>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Insert action like terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <c-f> <Right>
inoremap <c-b> <Left>
inoremap <c-a> <Esc>^i
inoremap <c-e> <Esc>$a
inoremap <c-w> <Esc>diwi
inoremap <c-u> <Esc>cc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 
set background=dark

try
    " let g:hybrid_custom_term_colors = 1
    " let g:hybrid_reduced_contrast = 1 
    " colorscheme hybrid

    " if !has('gui_running')
        " let g:PaperColor_Theme_Options = {
                    " \   'theme': {
                    " \     'default': {
                    " \       'transparent_background': 1
                    " \     }
                    " \   }
                    " \ }
    " endif
    " colorscheme PaperColor
    " colorscheme dracula
    " colorscheme gruvbox
    " let g:gruvbox_contrast_dark=dark
catch
endtry

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Open terminal in neovim.
tnoremap <Esc> <C-\><C-n>
map <F12> :bo sp term://zsh\|resize 5<CR>i

" Config netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3 " tree view
let g:netrw_altv = 1 " open splits to the right
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide = ',\(^\|\s\s\)\zs\.\S\+'


call plug#begin('~/.config/nvim/plugged')

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

Plug 'nanotech/jellybeans.vim'
colorscheme jellybeans

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_ShortcutB = '<Leader>bo'
let g:Lf_DefaultExternalTool = "ag"
" let g:Lf_UseVersionControlTool = "git ls-files"
let g:Lf_CommandMap = {'<C-C>': ['<Esc>', '<C-C>']}
let g:Lf_WindowHeight = 0.3
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}
let g:Lf_StlSeparator = { 'left': '', 'right': '' }

Plug 'mileszs/ack.vim' 
let g:ack_use_cword_for_empty_search = 1
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
vnoremap <silent> <leader>f :call visual#action('Ack! foo')<cr>
nnoremap <leader>f :Ack!<space>

Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
let NERDTreeIgnore=['\.pyc$', '\~$'] 
map <F1> :NERDTreeToggle<cr>
map <silent> <leader>j :NERDTreeFind<cr>

Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
map <silent> <F2> :TagbarToggle<cr>
imap <silent> <F2> <Esc>:TagbarToggle<cr>

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_quit_key='<C-c>'
let g:multi_cursor_skip_key='<C-x>'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1
map <leader>/ <leader>c<space>

" Initialize plugin system
Plug 'PangPangPangPangPang/visual-selection-vim'
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call visual#action('')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call visual#action('')<CR>?<C-R>=@/<CR><CR>
vnoremap <silent> <leader>f :call visual#action('Ack! foo')<CR>
nnoremap <leader>f :Ack! 
vnoremap <leader>r :call visual#replace('%s/foo//g')<CR><left><left>

" Install node and yarn before install the plugin.
" React support:CocInstall coc-tsserver coc-html coc-css
Plug 'neoclide/coc.nvim', {'do': 'yarn install'}

nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


""""""""""""Dart"""""""""""""""""""
Plug 'dart-lang/dart-vim-plugin', {'for': 'dart'}
"""""""""""""""""""""""""""""""""""

"""""""""""""""""""""FE""""""""""""""""""""
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'}

let g:used_javascript_libs = 'requirejs,vue,react,jquery'
Plug 'othree/xml.vim', {'for': ['html', 'xml']}

"react support
Plug 'chemzqm/vim-jsx-improve', {'for': 'javascript'}
"""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""Python""""""""""""""""
" Plug 'zchee/deoplete-jedi', {'for': 'python'}
"""""""""""""""""""""""""""""""""""""""

""""""""""""oc"""""""""""""""""""
Plug 'SolaWing/vim-objc-syntax', {'for': 'objc'}
"""""""""""""""""""""""""""""""""""

"Quick open doc
if has('mac')
    Plug 'rizzatti/dash.vim', {'on':[
                \  'Dash',
                \  'Dash!'
                \]}
    nnoremap <silent> <leader>z :Dash<cr>
else
    Plug 'KabbAmine/zeavim.vim', {'on': [
                \	'Zeavim', 'Docset',
                \	'<Plug>Zeavim',
                \	'<Plug>ZVVisSelection',
                \	'<Plug>ZVKeyDocset',
                \	'<Plug>ZVMotion'
                \ ]}
    nnoremap <silent> <leader>z :Zeavim<cr>
endif
"""""""""""""""""""""""""""""""""""""""""""
call plug#end()
