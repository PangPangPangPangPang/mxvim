""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Normal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Correct RGB escape codes for vim inside tmux
" if !has('nvim') && $TERM ==# 'screen-256color'
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" endif
if has("termguicolors")
    " fix bug for vim
    " set t_8f=^[[38;2;%lu;%lu;%lum
    " set t_8b=^[[48;2;%lu;%lu;%lum

    " enable true color
    set termguicolors
endif
" Sets how many lines of history VIM has to remember
set history=500
set mouse=a

" Show line numbers
set nu!

" Show relative line number
" set relativenumber

if has('mac') && !has('gui_running')
    set norelativenumber
endif

if has("patch-8.1.1564") || has('nvim-0.5')
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Allow use system clipboard
" set clipboard=unnamed

" Set to auto read when a file is changed from the outside
set autoread

let g:mapleader = "\<space>"

" Search down into subfolders
set path+=**

" Search tags 
set tags=./.tags;,.tags

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

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

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
autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go set shiftwidth=4
autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go set tabstop=4
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

" Move buffer
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>
map <leader>b1 :bf<cr>
map <leader>b2 :bf<cr>:bn<cr>
map <leader>b3 :bf<cr>:bn2<cr>
map <leader>b4 :bf<cr>:bn3<cr>
map <leader>b5 :bf<cr>:bn4<cr>
map <leader>b6 :bf<cr>:bn5<cr>
map <leader>b7 :bf<cr>:bn6<cr>
map <leader>b8 :bf<cr>:bn7<cr>
map <leader>b9 :bf<cr>:bn8<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


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

function! GetPyxVersion()
    try
        let l:pyx_version = execute('py3 print(sys.version)')[1:6]
    catch
        let l:pyx_version = ''
    endtry
    if l:pyx_version == ''
        try
            let l:pyx_version = execute('py print(sys.version)')[1:6]
        catch
            return 0
        endtry
    endif
    let s:python_version = str2float(l:pyx_version[0:2])
    if s:python_version > 3
        let g:pynvim_import = 0
        let g:ipdb_import = 0
python3 << Python3EOF
try:
    import vim
    import pynvim
except Exception:
    pass
else:
    vim.command('let g:pynvim_import = 1')
try:
    import ipdb
except Exception:
    pass
else:
    vim.command('let g:ipdb_import = 1')
Python3EOF
    endif
    if l:pyx_version[5] == ' '
        return s:python_version + str2float(l:pyx_version[4])/100
    else
        return s:python_version + str2float(l:pyx_version[4:5])/1000
    endif
endfunction
let g:python_version   = GetPyxVersion()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/vimrc.bundle"))
    source ~/.vim/vimrc.bundle
endif

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
    " colorscheme gruvbox8
    colorscheme gruvbox-material
    " let g:gruvbox_contrast_dark=dark
catch
endtry

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=L
    set guioptions-=R
    set guioptions-=r
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => For custom users modify their own config.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/vimrc.additional.bundle"))
    source ~/.vim/vimrc.additional.bundle
endif

""""""""""""""""""""""
"Quickly Run
""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        "        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

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
" if has('nvim')
    " tnoremap <Esc> <C-\><C-n>
    " map <F12> :bo sp term://zsh\|resize 5<CR>i
" else
    " map <F12> :rightbelow terminal ++rows=10 <cr><c-w>:set wfh<cr>
" endif
