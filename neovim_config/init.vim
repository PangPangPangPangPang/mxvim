""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Normal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable true color 启用终端24位色
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let g:mapleader = "\<space>"

set list lcs=tab:\|\ 

" Time for swap fill will be written to disk.
set updatetime=10

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
autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go set shiftwidth=4
autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go set tabstop=4
autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go set sts=4
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

" Config netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3 " tree view
let g:netrw_altv = 1 " open splits to the right
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide = ',\(^\|\s\s\)\zs\.\S\+'

call plug#begin('~/.config/nvim/plugged')

let g:PaperColor_Theme_Options = {
            \   'theme': {
            \     'default': {
            \       'transparent_background': 1
            \     }
            \   }
            \ }
Plug 'NLKNguyen/papercolor-theme'
colorscheme PaperColor
" colorscheme spring-night
" let g:one_allow_italics = 1

" colorscheme one

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
let NERDTreeIgnore=['\.pyc$', '\~$']
map <silent> <F1> :NERDTreeToggle<cr>
map <silent> <leader>j :NERDTreeFind<cr>

Plug 'liuchengxu/vista.vim'
map <silent> <F2> :Vista!!<cr>
imap <silent> <F2> <Esc>:Vista!!<cr>
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
            \ 'markdown': 'ctags',
            \ 'c': 'ctags',
            \ 'cpp': 'ctags',
            \}
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
let g:vista_echo_cursor_strategy= 'floating_win'
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

noremap <c-p> :FZF<cr>
let $FZF_DEFAULT_OPTS = '--layout=reverse'
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction
let g:fzf_action = {
            \ 'ctrl-l': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
function! OpenFloatingWin()
    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)
    let opts = {
                \ 'relative': 'editor',
                \ 'row': height * 0.3,
                \ 'col': col + 30,
                \ 'width': width * 2 / 3,
                \ 'height': height / 2,
                \ }

    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)

    " 设置浮动窗口高亮
    call setwinvar(win, '&winhl', 'Normal:Pmenu')

    setlocal
                \ buftype=nofile
                \ nobuflisted
                \ bufhidden=hide
                \ nonumber
                \ norelativenumber
                \ signcolumn=no
endfunction

Plug 'iamFIREcracker/ack.vim'
let g:ack_use_cword_for_empty_search = 1
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
let g:ack_use_async = 1
vnoremap <silent> <leader>p :call visual#action('Ack! foo')<cr>
" nnoremap <leader>p :Ack! <space>
nnoremap <leader>p :Ag<cr>


Plug 'mg979/vim-visual-multi'
let g:VM_maps = {}
let g:VM_maps['Remove Region'] = '<C-p>' " replace Q

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters={
            \ 'javascript': { 'left': '//', 'right': '', 'leftAlt': '{/*', 'rightAlt': '*/}' },
            \}
map <leader>/ <leader>c<space>

" Initialize plugin system
Plug 'PangPangPangPangPang/visual-selection-vim'
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call visual#action('')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call visual#action('')<CR>?<C-R>=@/<CR><CR>
vnoremap <leader>r :call visual#replace('%s/foo//g')<CR><left><left>

" Install node and yarn before install the plugin.
" React support:CocInstall coc-tsserver coc-html coc-css coc-snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions=[ 'coc-python', 'coc-json', 'coc-tsserver', 'coc-html', 'coc-css',  'coc-highlight', 'coc-snippets', 'coc-vimlsp', 'coc-tabnine' ]

nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" Remap for rename current word
nmap <leader>ar <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>af  <Plug>(coc-format-selected)
nmap <leader>af  <Plug>(coc-format-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
map <leader>ax  <Plug>(coc-fix-current)
" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

Plug 'w0rp/ale'
" Set ale disable as default
let g:ale_enabled = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_enter = 0

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '◎'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
" let g:ale_sign_column_always = 1
"
let g:ale_linters = {'jsx': ['stylelint', 'eslint'],
            \'python' : ['flake8'],
            \'go' : ['golint'],
            \ }
let g:ale_linter_aliases = {'jsx': 'css'}
" \   'go': ['remove_trailing_lines', 'trim_whitespace'],
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'go': ['gofmt', 'goimports'],
\}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_fix_on_save = 1

map <silent> <leader>s :ALEToggle<cr>
Plug 'maximbaz/lightline-ale'

" Add diagnostic info for https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'
let g:lightline = {
            \ 'active':{},
            \ 'inactive':{},
            \ }

let g:lightline.active.right = [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ], [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ]]
let g:lightline.active.left = [[ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ]]
let g:lightline.inactive.left = [[ 'filename' ]]
let g:lightline.inactive.right = []
let g:lightline.component_function = {
            \ 'cocstatus': 'coc#status',
            \ 'modified': 'LightlineModified',
            \ 'readonly': 'LightlineReadonly',
            \ 'filename': 'LightlineFilename',
            \ 'fileformat': 'LightlineFileformat',
            \ 'filetype': 'LightlineFiletype',
            \ 'fileencoding': 'LightlineFileencoding',
            \ 'mode': 'LightlineMode',
            \}
let g:lightline.colorscheme = 'one'
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.component_expand = {
            \  'linter_checking': 'lightline#ale#checking',
            \  'linter_warnings': 'lightline#ale#warnings',
            \  'linter_errors': 'lightline#ale#errors',
            \  'linter_ok': 'lightline#ale#ok',
            \ }
let g:lightline.component_type = {
            \     'linter_checking': 'left',
            \     'linter_warnings': 'warning',
            \     'linter_errors': 'error',
            \     'linter_ok': 'left',
            \ }

function! LightlineModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineFilename()
    let fname = expand('%:t')
    if fname == 'ControlP'
        return ''
    endif
    if fname =~ 'NERD_tree'
        return 'NERDTree'
    endif
    if fname =~ 'FZF'
        return 'FZF'
    endif
    if fname =~ '__Tagbar__'
        return 'Tagbar'
    endif

    return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction




""""""""""""Markdown"""""""""""""""""""
Plug 'iamcco/markdown-preview.vim'
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

Plug 'tweekmonster/startuptime.vim', {'on': ['StartupTime']}

" Quick toggle terminal.
Plug 'PangPangPangPangPang/vim-terminal'
map <silent> <F5> :VSTerminalToggle<cr>
if has('nvim')
    tnoremap <silent> <F5> <C-\><C-n> :VSTerminalToggle<cr>
    tnoremap <silent> <C-w> <C-\><C-n><C-w>
    tnoremap <silent> <Esc> <C-\><C-n>
else
    tmap <silent> <F5> <c-w>:VSTerminalToggle<cr>
endif
let g:vs_terminal_custom_height = 10

Plug 'Yggdroot/indentLine'

" Git status plugin
Plug 'airblade/vim-gitgutter'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Snip plugin
Plug 'honza/vim-snippets'

" Hightlight plugin
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown']

" Manage input method.
if has("mac")
    Plug 'ybian/smartim'
    let g:smartim_default = 'com.apple.keylayout.ABC'
else
    Plug 'rlue/vim-barbaric'
endif

" Highlight f/F/t/T search.
Plug 'rhysd/clever-f.vim'
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" Highlight yank.
Plug 'machakann/vim-highlightedyank'

"""""""""""""'go'"""""""""""""
" Plug 'fatih/vim-go', { 'for' : 'go' }
" let g:go_code_completion_enabled = 0

Plug 'sebdah/vim-delve', { 'for' : 'go' }
let g:delve_new_command = 'new'
autocmd FileType go nmap <silent> <F3> :DlvDebug<CR>
autocmd FileType go nmap <silent> <F4> :DlvToggleBreakpoint<CR>
""""""""""""""""""""""""""""""
Plug 'easymotion/vim-easymotion'
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

call plug#end()
