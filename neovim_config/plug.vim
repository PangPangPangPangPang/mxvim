
call plug#begin('~/.config/nvim/plugged')

Plug 'ryanoasis/vim-devicons'

" Theme
" Plug 'dracula/vim'
" Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-gruvbox8'
" Plug 'arzg/vim-colors-xcode'
" Plug 'Dave-Elec/gruvbox'
" Plug 'srcery-colors/srcery-vim'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'rakr/vim-one'

" Plug 'sainnhe/vim-color-forest-night'
" Readline style insertion
Plug 'tpope/vim-rsi'

Plug 'mhinz/vim-startify'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

if has('python3')
    if has('nvim')
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'kristijanhusak/defx-icons'
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
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
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
" Plug 'PangPangPangPangPang/vim-terminal'
" map <silent> <F5> :VSTerminalToggle<cr>

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
"""""""""""""flutter"""""""""""""
let g:flutter_command= '~/motor_flutter/.flutterw/cache/dist/bd_1.5.4/flutter/bin/flutter'
let g:flutter_show_log_on_attach = 1
Plug 'PangPangPangPangPang/vim-flutter', {'for': 'dart'}
autocmd FileType dart nnoremap <buffer> <leader>fs :FlutterRun<cr>
autocmd FileType dart nnoremap <buffer> <leader>fr :FlutterHotReload<cr>
autocmd FileType dart nnoremap <buffer> <leader>fa :FlutterAttach<cr>
autocmd FileType dart nnoremap <buffer> <leader>fq :FlutterQuit<cr>
autocmd FileType dart nnoremap <buffer> <leader>fR :FlutterHotRestart<cr>
""""""""""""""""""""""""""""""
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Add mark
Plug 'kshenoy/vim-signature'

Plug 'PangPangPangPangPang/ywvim'
let g:ywvim_ims=[
            \['py', '拼音', 'pinyin.ywvim'],
            \]
let g:ywvim_zhpunc = 1
let g:ywvim_listmax = 10
let g:ywvim_esc_autoff = 0
let g:ywvim_autoinput = 0
let g:ywvim_circlecandidates = 1
let g:ywvim_helpim_on = 1
let g:ywvim_matchexact = 0
let g:ywvim_chinesecode = 1
let g:ywvim_gb = 0
let g:ywvim_preconv = 'g2b'
let g:ywvim_conv = ''
let g:ywvim_lockb = 1
let g:ywvim_theme = 'light'
if has('vim')
    let g:ywvim_popupwin=1
    let g:ywvim_popupwin_follow_cursor=1
    let g:ywvim_popupwin_horizontal=0
endif

Plug 'simnalamburt/vim-mundo'
Plug 'skywind3000/vim-terminal-help'
let g:terminal_auto_insert = 1
let g:terminal_key = "<F5>"
let g:terminal_cwd = 2
let g:terminal_height = 20
let g:terminal_list = 0
let g:terminal_kill = "term"

Plug 'pechorin/any-jump.vim', { 'on': 'AnyJump' }

call plug#end()

" Load plugin config.
for f in split(glob('~/.config/nvim/plugin_config/*.vim'))
    exe 'source' f
endfor

