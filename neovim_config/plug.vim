call plug#begin('~/.config/nvim/plugged')

" Plug 'NLKNguyen/papercolor-theme'
" Plug 'morhetz/gruvbox'
Plug 'srcery-colors/srcery-vim'


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
    Plug 'kristijanhusak/defx-git'
else
    Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
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
let g:AutoPairsFlyMode = 0

Plug 'tpope/vim-surround'

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
" Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Snip plugin
Plug 'honza/vim-snippets'

" Hightlight plugin
Plug 'sheerun/vim-polyglot'

" Manage input method.
if has("mac")
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

""""""""""""""""""""""""""""""
" Add mark
Plug 'kshenoy/vim-signature'

call plug#end()

" Load plugin config.
for f in split(glob('~/.config/nvim/plugin_config/*.vim'))
    exe 'source' f
endfor
