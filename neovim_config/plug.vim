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
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-gruvbox8'
" Plug 'connorholyday/vim-snazzy'
" Plug 'chuling/equinusocio-material.vim'
" Plug 'ajmwagar/vim-deus'
" Plug 'arzg/vim-colors-xcode'
" Plug 'Dave-Elec/gruvbox'
" Plug 'srcery-colors/srcery-vim'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'rakr/vim-one'
" Plug 'joshdick/onedark.vim'
" Plug 'franbach/miramare'
" Plug 'dracula/vim', { 'as': 'dracula' }


" Plug 'sainnhe/vim-color-forest-night'
" Readline style insertion
Plug 'tpope/vim-rsi'

let entry_format = "'   ['. index .']'. repeat(' ', (3 - strlen(index)))"

Plug 'mhinz/vim-startify'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

if has('python3')
" if 0
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

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" let g:deoplete#enable_at_startup = 1
" Plug 'beeender/Comrade'

Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
let g:lightline#bufferline#show_number = 1

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


let g:indentLine_char = '⎸'
" let g:indentLine_char = '┆'
Plug 'Yggdroot/indentLine'

" Git support
Plug 'airblade/vim-gitgutter'
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_sign_priority = 1
let g:gitgutter_override_sign_column_highlight = 0

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'

" Snip plugin
Plug 'honza/vim-snippets'

" Hightlight plugin
let g:polyglot_disabled = ['markdown', 'mathematica']
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
" Plug 'jackguo380/vim-lsp-cxx-highlight'

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
nnoremap <silent> <F6> :MundoToggle<CR>

Plug 'skywind3000/vim-terminal-help'
let g:terminal_auto_insert = 1
let g:terminal_key = "<F5>"
let g:terminal_cwd = 2
let g:terminal_height = 20
let g:terminal_list = 0
let g:terminal_kill = "term"

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

if has('nvim-0.5')
    Plug 'nvim-treesitter/nvim-treesitter', { 'commit': '599bec38900b2a7eaeb05a44807d6ab70911e522' }
endif

" Automatically highlighting other uses of the current word under the cursor
Plug 'RRethy/vim-illuminate'
call plug#end()

" Load plugin config.
for f in split(glob('~/.config/nvim/plugin_config/*.vim'))
    exe 'source' f
endfor
