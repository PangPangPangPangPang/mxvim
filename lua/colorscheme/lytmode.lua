local M = {}
M.config = function()
  require("lytmode").setup({
    transparent = false,
    italic_comments = true,
  })
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  return {
    fg = "#c7cfe5", -- light text color
    bg = "#2d3039", -- background color
    yellow = "#d7d583",
    cyan = "#71c2d4",
    darkblue = "#4f7984",
    green = "#1dc7a0",
    orange = "#f8a257",
    purple = "#b894ff",
    magenta = "#ff7fb6",
    blue = "#38b4da",
    red = "#fb5f8e",
    line_fg = "#7c849c",
  }
end
return M
