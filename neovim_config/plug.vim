
call plug#begin('~/.config/nvim/plugged')

" Theme
" Plug 'dracula/vim'
" Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-gruvbox8'
" Plug 'Dave-Elec/gruvbox'
" Plug 'srcery-colors/srcery-vim'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'rakr/vim-one'


Plug 'mhinz/vim-startify'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

if has('python3')
    if has('nvim')
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/defx.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    let g:mx_loaded_defx = 1
    " Plug 'kristijanhusak/defx-git'
else
    Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
    let g:mx_loaded_nerdtree = 1
endif


Plug 'liuchengxu/vista.vim'

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }


Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'mhinz/vim-grepper'

Plug 'mg979/vim-visual-multi'
let g:VM_maps = {}
let g:VM_maps['Remove Region'] = '<C-p>' " replace Q

Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-surround'
let @t="\m\`\$v\^S\]\`\`"
nnoremap <leader>] = @t

Plug 'scrooloose/nerdcommenter'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

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

" Initialize plugin system
Plug 'PangPangPangPangPang/visual-selection-vim'
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call visual#action('')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call visual#action('')<CR>?<C-R>=@/<CR><CR>
vnoremap <leader>r :call visual#replace('%s/foo//g')<CR><left><left>


Plug 'Yggdroot/indentLine'

" Git support
Plug 'airblade/vim-gitgutter'
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_sign_priority = 1
let g:gitgutter_override_sign_column_highlight = 0

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Snip plugin
Plug 'honza/vim-snippets'
let g:polyglot_disabled = ['markdown']

" Hightlight plugin
Plug 'sheerun/vim-polyglot'

" Manage input method.
if has("mac") && has("nvim")
    Plug 'lyokha/vim-xkbswitch'
    let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
    let g:XkbSwitchEnabled = 1
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
Plug 'fatih/vim-go', { 'for' : 'go' }
Plug 'sebdah/vim-delve', { 'do': ':GoUpdateBinaries', 'for': 'go' }

"""""""""""""'objc'"""""""""""""
Plug 'SolaWing/vim-objc-syntax', {'for': 'objc'}

""""""""""""""""""""""""""""""
" Add mark
Plug 'kshenoy/vim-signature'

Plug 'skanehira/preview-markdown.vim'
call plug#end()

" Load plugin config.
for f in split(glob('~/.config/nvim/plugin_config/*.vim'))
    exe 'source' f
endfor
