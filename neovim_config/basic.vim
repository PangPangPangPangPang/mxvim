" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set list lcs=tab:\|\ 

" Time for swap fill will be written to disk.
set updatetime=10

" Sets how many lines of history VIM has to remember
set history=500

set colorcolumn=81

" Show line numbers
set nu!

if has('gui_running') || has('nvim')
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

" Turn on the wild menu
set wildmenu

" Popup menu height
set pumheight=20

if exists('&pumblend')
    set wildoptions=pum
    set pumblend=20
endif

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set completeopt=longest,menu

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

nmap n nzz
nmap N Nzz

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


" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set nowrap "Wrap lines
set sidescroll=1

set splitright
set splitbelow

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab
    set stal=2
catch
endtry

" Close quickfix window
map <leader>q :cclose<cr> :pclose<cr>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Whole format
nnoremap <leader>== mzG=gg`z

" Copy to system clipboard
map Y "+y

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

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

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Config netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3 " tree view
let g:netrw_altv = 1 " open splits to the right
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide = ',\(^\|\s\s\)\zs\.\S\+'

augroup BasicGroup
    " 1 tab == 4 spaces
    autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go,objc set shiftwidth=4
    autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go,objc set tabstop=4
    autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go,objc set sts=4
    autocmd FileType javascriptreact,javascript,html,css,xml,dart,swift,json set shiftwidth=2
    autocmd FileType javascriptreact,javascript,html,css,xml,dart,swift,json set tabstop=2
    autocmd FileType javascriptreact,javascript,html,css,xml,dart,swift,json set sts=2

    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup End
