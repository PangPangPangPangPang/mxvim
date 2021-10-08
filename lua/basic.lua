
local o = vim.o
local fn = vim.fn
local g = vim.g
local cmd = vim.cmd
local dmap = require('utils').dmap

vim.o.background = mxvim.background

-- disable netrw
-- g.loaded_netrwPlugin = 1
-- Config netrw
g.netrw_banner = 0
g.netrw_liststyle = 3 -- tree view
g.netrw_altv = 1 -- open splits to the right

g.mapleader = ' '
g.use_lua = 1

o.mouse = 'a'
o.showmode = false

if fn.has('nvim-0.5') then
    o.jumpoptions = 'stack'
end

o.cursorline = true

-- Time for swap fill will be written to disk.
o.updatetime = 400

-- Sets how many lines of history VIM has to remember
o.history = 500

-- Don't pass messages to |ins-completion-menu|.
o.shortmess = o.shortmess .. 'c'

-- show line numbers
-- o.relativenumber = true
o.nu = true

if fn.has('patch-8.1.1564') or fn.has('nvim-0.5') then
    o.signcolumn = 'yes'
    o.foldcolumn = '0'
else
    -- o.signcolum = 'number'
    o.foldcolumn = '0'
end

-- o.to auto read when a file is changed from the outside
g.autoread = true

-- Search down into subfolders
o.path = o.path .. '**'

-- Search tags
o.tags = './.tags;,.tags'

-- vim.cmd('filetype on')
-- vim.cmd('filetype indent on')

-- o.3 lines to the cursor - when moving vertically using j/k
o.so = 3

-- Avoid garbled characters in Chinese language windows OS
o.langmenu = 'en'

-- Turn on the wild menu
o.wildmenu = true

-- Popup menu height
o.pumheight = 20

if fn.exists('&pumblend') then
    o.wildoptions = 'pum'
    o.pumblend = 20
end

o.wildignore = '*.o,*~,*.pyc'
if fn.has('win16') or fn.has('win32') then
    o.wildignore = o.wildignore .. '.git*,.hg*,.svn*'
else
    o.wildignore = o.wildignore .. '*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store'
end

o.completeopt = 'menu,menuone,noinsert'

-- Always show current position
o.ruler = true

-- Height of the command bar
o.cmdheight = 1

-- A buffer becomes hidden when it is abandoned
o.hid = true

-- Configure backspace so it acts as it should act
o.backspace = 'eol,start,indent'
o.whichwrap = o.whichwrap .. '<,>,h,l'

-- Ignore case when searching
o.ignorecase = true

-- When searching try to be smart about cases
o.smartcase = true


-- Highlight search results
o.hlsearch = true

-- Makes search act like search in modern browsers
o.incsearch = true

-- Don't redraw while executing macros (good performance config)
o.lazyredraw = true

-- For regular expressions turn magic on
o.magic = true

-- Show matching brackets when text indicator is over them
o.showmatch = true
-- How many tenths of a second to blink when matching brackets
o.mat = 2

-- No annoying sound on errors
o.errorbells = false
o.visualbell = false
o.tm = 500

--------------------------------------------------
-- => Files, backups and undo
--------------------------------------------------
-- Turn backup off, since most stuff is in SVN, git et.c anyway...
o.backup = false
o.wb = false
o.swapfile = false

--------------------------------------------------
-- => Text, tab and indent related
--------------------------------------------------
-- Use spaces instead of tabs
o.expandtab = true

-- Be smart when using tabs ;)
o.smarttab = true

-- o.shiftwidth=4
-- o.tabstop=4


-- Linebreak on 500 characters
o.lbr = true
o.tw=500

-- Auto indent
o.ai  = true
-- Smart indent
o.si  = true
-- Wrap lines
o.wrap  = false
o.sidescroll = 1

o.splitright = true
o.splitbelow = true

o.switchbuf='useopen,usetab'
o.showtabline=1

dmap({'n', 'v'}, '<leader>q', ':lua require("utils").close_common()<cr>')
------------------------------
-- => Status line
------------------------------
-- Always show the status line
o.laststatus=2
-- Whole format
dmap({'n'}, '<leader>==', 'mzG=gg`z')
-- Copy to system clipboard
dmap({'v'}, 'Y', '"+y')

-- replace current word
require('utils').map({'v'}, '<leader>r', '"hy:%s/<C-r>h//gc<left><left><left>', { noremap = true })

-- Set utf8 as standard encoding and en_US as the standard language
o.encoding='utf8'

-- Use Unix as the standard file type
o.ffs='unix,dos,mac'

if vim.fn.exists('+termguicolors') then
    vim.o.termguicolors = true
end

cmd([[
    command! -nargs=0 CD :execute("cd %:p:h")
    augroup BasicGroup
        " 1 tab == 4 spaces
        autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go,objc,swift,lua set shiftwidth=4
        autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go,objc,swift,lua set tabstop=4
        autocmd FileType php,python,c,java,perl,shell,sh,vim,ruby,cpp,go,objc,swift,lua set sts=4

        autocmd FileType javascriptreact,javascript,typescript,typescriptreact,html,css,xml,dart,json,less,markdown set shiftwidth=2
        autocmd FileType javascriptreact,javascript,typescript,typescriptreact,html,css,xml,dart,json,less,markdown set tabstop=2
        autocmd FileType javascriptreact,javascript,typescript,typescriptreact,html,css,xml,dart,json,less,markdown set sts=2

        " Return to last edit position when opening files (You want this!)
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}
    augroup End
    augroup tt_ft
        autocmd!
        autocmd BufNewFile,BufRead *.ttss   set filetype=css
        autocmd BufNewFile,BufRead *.ttml   set filetype=html
    augroup END
]])

pcall(require, 'private')

if fn.exists('g:neovide') == 1 then
    g.neovide_cursor_trail_size = 0.1
    g.neovide_cursor_vfx_mode = "railgun"
    if require('utils').system() == 'Linux' then
        o.guifont = 'MaxIosevka Nerd Font:h10'
    else
        o.guifont = 'MaxIosevka Nerd Font:h14'
    end
    -- g.smoothie_enabled = false
end