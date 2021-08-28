vim.o.mouse = 'a'

vim.o.showmode = false

if vim.fn.has('nvim-0.5') then
    vim.o.jumpoptions = 'stack'
end

vim.o.cursorline = true

-- Time for swap fill will be written to disk.
vim.o.updatetime = 400

-- Sets how many lines of history VIM has to remember
vim.o.history = 500

-- Don't pass messages to |ins-completion-menu|.
vim.o.shortmess = vim.o.shortmess .. 'c'

-- show line numbers
-- vim.o.relativenumber = true
vim.o.nu = true

if vim.fn.has('patch-8.1.1564') or vim.fn.has('nvim-0.5') then
    vim.o.signcolumn = 'yes'
    vim.o.foldcolumn = '0'
else
    -- vim.o.signcolum = 'number'
    vim.o.foldcolumn = '0'
end

-- vim.o.to auto read when a file is changed from the outside
vim.g.autoread = true

-- Search down into subfolders
vim.o.path = vim.o.path .. '**'

-- Search tags
vim.o.tags = './.tags;,.tags'

vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')

-- vim.o.3 lines to the cursor - when moving vertically using j/k
vim.o.so = 3

-- Avoid garbled characters in Chinese language windows OS
vim.o.langmenu = 'en'

-- Turn on the wild menu
vim.o.wildmenu = true

-- Popup menu height
vim.o.pumheight = 20

if vim.fn.exists('&pumblend') then
    vim.o.wildoptions = 'pum'
    vim.o.pumblend = 20
end

vim.o.wildignore = '*.o,*~,*.pyc'
if vim.fn.has('win16') or vim.fn.has('win32') then
    vim.o.wildignore = vim.o.wildignore .. '.git*,.hg*,.svn*'
else
    vim.o.wildignore = vim.o.wildignore .. '*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store'
end

vim.o.completeopt = 'menuone,noselect'

-- Always show current position
vim.o.ruler = true

-- Height of the command bar
vim.o.cmdheight = 1

-- A buffer becomes hidden when it is abandoned
vim.o.hid = true

-- Configure backspace so it acts as it should act
vim.o.backspace = 'eol,start,indent'
vim.o.whichwrap = vim.o.whichwrap .. '<,>,h,l'

-- Ignore case when searching
vim.o.ignorecase = true

-- When searching try to be smart about cases
vim.o.smartcase = true


-- Highlight search results
vim.o.hlsearch = true

-- Makes search act like search in modern browsers
vim.o.incsearch = true

-- Don't redraw while executing macros (good performance config)
vim.o.lazyredraw = true

-- For regular expressions turn magic on
vim.o.magic = true

-- Show matching brackets when text indicator is over them
vim.o.showmatch = true
-- How many tenths of a second to blink when matching brackets
vim.o.mat = 2

-- No annoying sound on errors
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.t_vb = ''
vim.o.tm = 500

--------------------------------------------------
-- => Files, backups and undo
--------------------------------------------------
-- Turn backup off, since most stuff is in SVN, git et.c anyway...
vim.o.backup = false
vim.o.wb = false
vim.o.swapfile = false

--------------------------------------------------
-- => Text, tab and indent related
--------------------------------------------------
-- Use spaces instead of tabs
vim.o.expandtab = true

-- Be smart when using tabs ;)
vim.o.smarttab = true

-- vim.o.shiftwidth=4
-- vim.o.tabstop=4


-- Linebreak on 500 characters
vim.o.lbr = true
vim.o.tw=500

-- Auto indent
vim.o.ai  = true
-- Smart indent
vim.o.si  = true
-- Wrap lines
vim.o.wrap  = false
vim.o.sidescroll = 1

vim.o.splitright = true
vim.o.splitbelow = true
