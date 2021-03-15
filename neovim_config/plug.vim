if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter *PlugInstall --sync | source $MYVIMRC
endif

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

function! Installed(value)
    return has_key(g:plugs, a:value)
endfunction

call plug#begin('~/.config/nvim/plugged')

Plug 'ryanoasis/vim-devicons'
let g:devicons_install = 1

" Theme
" Plug 'dracula/vim'
" Plug 'morhetz/gruvbox'
" Plug 'gruvbox-community/gruvbox'
" Plug 'sainnhe/gruvbox-material'
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'connorholyday/vim-snazzy'
" Plug 'chuling/equinusocio-material.vim'
" Plug 'ajmwagar/vim-deus'
" Plug 'arzg/vim-colors-xcode'
" Plug 'Dave-Elec/gruvbox'
" Plug 'srcery-colors/srcery-vim'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'rakr/vim-one'
" Plug 'joshdick/onedark.vim'
" Plug 'PangPangPangPangPang/miramare', { 'branch': 'develop' }
Plug 'nanotech/jellybeans.vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'christianchiarulli/nvcode-color-schemes.vim'


" Plug 'sainnhe/vim-color-forest-night'
" Readline style insertion
Plug 'tpope/vim-rsi'

" vim-cool disables search highlighting when you are done searching and re-enables it when you search again.
Plug 'romainl/vim-cool'
let g:CoolTotalMatches = 1

let entry_format = "'   ['. index .']'. repeat(' ', (3 - strlen(index)))"

Plug 'mhinz/vim-startify'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

if has('python3')
    if has('nvim')
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' } | Plug 'kristijanhusak/defx-icons' | Plug 'kristijanhusak/defx-git'
    else
        Plug 'Shougo/defx.nvim' | Plug 'roxma/nvim-yarp' | Plug 'roxma/vim-hug-neovim-rpc'
    endif
    
else
    Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
    Plug 'Xuyuanp/nerdtree-git-plugin'
endif

" Highlight yank.
Plug 'machakann/vim-highlightedyank'

Plug 'liuchengxu/vista.vim', {'on': ['Vista!!']}


" Fuzzy finder
if has('nvim-0.5')
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    " Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
endif

" Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-grepper', { 'on': ['GrepperRg', 'Grepper', '<plug>(GrepperOperator)'] }


Plug 'mg979/vim-visual-multi'
let g:VM_maps = {}
let g:VM_maps['Remove Region'] = '<C-p>' " replace Q

Plug 'jiangmiao/auto-pairs'
" Plug 'tmsvg/pear-tree'
" let g:pear_tree_repeatable_expand = 0
" let g:pear_tree_pairs = {
"             \ '(': {'closer': ')'},
"             \ '[': {'closer': ']'},
"             \ '{': {'closer': '}'},
"             \ "'": {'closer': "'"},
"             \ '"': {'closer': '"'},
"             \ '<*>': {'closer': '</*>'},
"             \ }

Plug 'tpope/vim-surround'
let @t="\m\`\$v\^S\]\`\`"
nnoremap <leader>] = @t

Plug 'scrooloose/nerdcommenter'
" Plug 'tpope/vim-commentary'
" For tsx/jsx comment
" Plug 'suy/vim-context-commentstring'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-lua/diagnostic-nvim'

let g:ale_disable_lsp = 1
let g:ale_enabled = 0
Plug 'dense-analysis/ale'

if !has('nvim-0.5')
    Plug 'itchyny/lightline.vim'
    if g:ale_enabled == 1
        Plug 'maximbaz/lightline-ale'
    endif
else 
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
endif
" Plug 'TaDaa/vimade'

" Plug 'mengelbrecht/lightline-bufferline'
" let g:lightline#bufferline#show_number = 1

""""""""""""Markdown"""""""""""""""""""
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

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
Plug 'szw/vim-maximizer', {'on': 'MaximizerToggle'}
nnoremap <silent><C-w>z :MaximizerToggle<CR>
vnoremap <silent><C-w>z :MaximizerToggle<CR>gv

Plug 'dstein64/vim-startuptime', {'on': ['StartupTime']}

" Quick toggle terminal.
" Plug 'PangPangPangPangPang/vim-terminal'
" map <silent> <F5> :VSTerminalToggle<cr>

" Initialize plugin system
Plug 'PangPangPangPangPang/visual-selection-vim'
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call visual#action('')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call visual#action('')<CR>?<C-R>=@/<CR><CR>
vnoremap <leader>r :call visual#replace('%s/foo//g')<CR><left><left>

let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['markdown', 'coc-explorer']
Plug 'Yggdroot/indentLine'

" Git support
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'

" Snip plugin
Plug 'honza/vim-snippets'

" Hightlight plugin
if !has('nvim-0.5')
    let g:polyglot_disabled = ['markdown', 'mathematica']
    Plug 'sheerun/vim-polyglot'
endif

" Manage input method.
if has("mac") && has("nvim")
else
    Plug 'rlue/vim-barbaric'
endif

" Highlight f/F/t/T search.
Plug 'rhysd/clever-f.vim'
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

"""""""""""""'go'"""""""""""""
Plug 'fatih/vim-go', { 'for' : 'go' }
Plug 'sebdah/vim-delve', { 'do': ':GoUpdateBinaries', 'for': 'go' }

"""""""""""""'objc'"""""""""""""
Plug 'SolaWing/vim-objc-syntax', {'for': 'objc'}
""""""""""""""""""""""""""""""

" Add mark
Plug 'kshenoy/vim-signature'

" Plug 'PangPangPangPangPang/ywvim'

Plug 'simnalamburt/vim-mundo'
nnoremap <silent> <F6> :MundoToggle<CR>

Plug 'skywind3000/vim-terminal-help'
let g:terminal_auto_insert = 1
let g:terminal_key = "<F5>"
let g:terminal_cwd = 2
let g:terminal_height = 20
let g:terminal_list = 0
let g:terminal_kill = "term"
" Plug 'voldikss/vim-floaterm'
" let g:floaterm_keymap_toggle = '<F5>'

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Illuminate_highlightUnderCursor = 1
let g:Illuminate_ftblacklist = ['defx', 'vista', 'nerdtree']

if has('nvim-0.5')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
endif

" Automatically highlighting other uses of the current word under the cursor
Plug 'RRethy/vim-illuminate'

" DB
Plug 'tpope/vim-dadbod', {'on': [ 'DB' ]}

Plug 'mattn/emmet-vim'
let g:user_emmet_expandabbr_key = '<C-y><tab>'
let g:user_emmet_prev_key = '<C-y>p'

Plug 'skywind3000/vim-quickui'
let g:quickui_border_style = 2
let g:quickui_color_scheme = 'system'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'

call plug#end()

" Load plugin config.
for f in split(glob('~/.config/nvim/plugin_config/*.vim'))
    exe 'source' f
endfor
