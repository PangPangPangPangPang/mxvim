local M = {}
M.config = function()
  require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = true,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = false, -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
  })
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  return {
    fg = "#ebdbb2", -- light text color
    bg = "#3c3836", -- background color
    yellow = "#fabd2f",
    cyan = "#8ec07c",
    darkblue = "#83a598",
    green = "#b8bb26",
    orange = "#fe8019",
    purple = "#924f79",
    magenta = "#d3869b",
    blue = "#83a598",
    red = "#fb4934",
  }
end
return M