local o = vim.o
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local dmap = require("utils").dmap

o.background = mxvim.background
g.editorconfig = true

o.winblend = fn.exists("g:neovide") == 1 and 30 or 10

-- disable netrw
g.loaded_netrwPlugin = 1
-- Config netrw
g.netrw_banner = 0
g.netrw_liststyle = 3 -- tree view
g.netrw_altv = 1 -- open splits to the right

g.mapleader = " "
g.use_lua = 1

o.mouse = "a"
o.showmode = false

if fn.has("nvim-0.5") then
  o.jumpoptions = "stack"
end

o.laststatus = 2
--
o.cursorline = true

-- Time for swap fill will be written to disk.
o.updatetime = 400

-- Sets how many lines of history VIM has to remember
o.history = 500

-- Don't pass messages to |ins-completion-menu|.
o.shortmess = o.shortmess .. "c"

-- show line numbers
-- o.relativenumber = true

o.nu = true
o.signcolumn = "yes"

-- o.to auto read when a file is changed from the outside
g.autoread = true

-- Search down into subfolders
o.path = o.path .. "**"

-- Search tags
o.tags = "./.tags;,.tags"

-- o.3 lines to the cursor - when moving vertically using j/k
o.so = 3

-- Avoid garbled characters in Chinese language windows OS
o.langmenu = "en"

-- Turn on the wild menu
o.wildmenu = true

-- Popup menu height
o.pumheight = 20

if fn.exists("&pumblend") then
  o.wildoptions = "pum"
  o.pumblend = 10
end

o.wildignore = "*.o,*~,*.pyc"
if fn.has("win16") or fn.has("win32") then
  o.wildignore = o.wildignore .. ".git*,.hg*,.svn*"
else
  o.wildignore = o.wildignore .. "*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"
end

o.completeopt = "menu,menuone,noinsert,noselect"

-- Always show current position
o.ruler = true

-- Height of the command bar
if fn.has("nvim-0.8") then
  o.cmdheight = 0
end

-- A buffer becomes hidden when it is abandoned
o.hid = true

-- Configure backspace so it acts as it should act
o.backspace = "eol,start,indent"
o.whichwrap = o.whichwrap .. "<,>,h,l"

-- Ignore case when searching
o.ignorecase = true

-- When searching try to be smart about cases
o.smartcase = true

-- Highlight search results
o.hlsearch = true

-- Makes search act like search in modern browsers
o.incsearch = true

-- Don't redraw while executing macros (good performance config)
o.lazyredraw = false

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
o.tw = 500

-- Auto indent
o.ai = true
-- Smart indent
o.si = true
-- Wrap lines
o.wrap = false
o.sidescroll = 1
o.sidescrolloff = 999

o.splitright = true
o.splitbelow = true

o.switchbuf = "useopen,usetab"
o.showtabline = 1

-- replace current word
require("utils").map({ "v" }, "<leader>rr", '"hy:%s/<C-r>h//g<left><left>', { noremap = true })

-- Set utf8 as standard encoding and en_US as the standard language
o.encoding = "utf8"

-- Use Unix as the standard file type
o.ffs = "unix,dos,mac"

if vim.fn.exists("+termguicolors") then
  vim.o.termguicolors = true
end

opt.fillchars:append({
  eob = " ",
  -- vert = "│",
  vert = "▏",
  vertleft = "▏",
  vertright = "▏",
  verthoriz = "─",
  horiz = "─",
  horizup = "─",
  horizdown = "─",
  diff = "╱",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  fold = " ",
  msgsep = "─",
})

opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

require("utils").hook_print()
-- if vim.fn.has('nvim-0.9') == 1 then

-- Source the switch.vim file
cmd([[source ~/.config/nvim/viml/switch.vim]])

-- Create CD command
vim.api.nvim_create_user_command("CD", function()
  vim.cmd("cd %:p:h")
end, {})

-- Create last_edit_group for autocommands
local last_edit_group = vim.api.nvim_create_augroup("last_edit_group", { clear = true })

-- Return to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = last_edit_group,
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = last_edit_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Search", timeout = 500 })
  end,
})

-- Create tt_ft group for file type settings
local tt_ft_group = vim.api.nvim_create_augroup("tt_ft", { clear = true })

-- Set filetype for .ttss and .ttml files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = tt_ft_group,
  pattern = "*.ttss",
  callback = function()
    vim.bo.filetype = "css"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = tt_ft_group,
  pattern = "*.ttml",
  callback = function()
    vim.bo.filetype = "html"
  end,
})

local ftgroup = vim.api.nvim_create_augroup("ft_group", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = ftgroup,
  pattern = {
    "php",
    "python",
    "c",
    "java",
    "perl",
    "shell",
    "sh",
    "vim",
    "ruby",
    "cpp",
    "go",
    "objc",
    "swift",
    "lua",
  },
  callback = function()
    -- 1 tab == 4 spaces
    o.shiftwidth = 4
    o.tabstop = 4
    o.sts = 4
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = ftgroup,
  pattern = {
    "javascriptreact",
    "javascript",
    "typescript",
    "typescriptreact",
    "html",
    "css",
    "xml",
    "dart",
    "json",
    "less",
    "markdown",
  },
  callback = function()
    -- 1 tab == 4 spaces
    o.shiftwidth = 2
    o.tabstop = 2
    o.sts = 2
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = ftgroup,
  pattern = { "*.podspec", "Podfile" },
  callback = function()
    o.filetype = "ruby"
  end,
})

pcall(require, "private")

if fn.exists("g:neovide") == 1 then
  -- for paste
  dmap({ "i", "v" }, "<c-v>", '"+p')
  dmap({ "n", "v" }, "<c-c>", '"+y')
  dmap({ "c", "i" }, "<c-v>", "<c-r>+")
  dmap({ "i" }, "<c-r>", "<c-v>")
  dmap({ "n", "v" }, "<D-v>", '"+p')
  dmap({ "n", "v" }, "<D-c>", '"+y')
  dmap({ "c", "i" }, "<D-v>", "<c-r>+")
  dmap({ "i" }, "<D-r>", "<D-v>")

  vim.opt.linespace = 8
  g.neovide_fullscreen = true
  g.neovide_floating_corner_radius = 0.2
  g.neovide_normal_opacity = 1
  g.neovide_window_blurred = true
  g.neovide_floating_blur_amount_x = 6.0
  g.neovide_floating_blur_amount_y = 6.0
  -- g.neovide_cursor_vfx_mode = "sonicboom"
  g.neovide_cursor_trail_size = 0.1

  g.neovide_text_gamma = 0.8
  g.neovide_text_contrast = 1

  g.neovide_padding_top = 12
  g.neovide_padding_bottom = 0
  g.neovide_padding_right = 12
  g.neovide_padding_left = 12
  -- o.guifont = "Iosevka Nerd Font:h17"
  o.guifont = "DinaTtf10px Nerd Font:h18"
  g.neovide_scroll_animation_length = 0.3
elseif g.gonvim_running == 1 then
  if require("utils").system() == "Linux" then
    o.guifont = "Iosevka Nerd Font:h10"
  else
    o.guifont = "Iosevka Nerd Font:h14"
  end
end