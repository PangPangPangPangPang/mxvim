local M = {}
M.config = function()
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  return {
    fg = "#D7D7D7",
    bg = "#1B1D26",
    light_bg = "#D7D7D7",
    light_fg = "#1B1D26",

    yellow = "#E3CF65",
    cyan = "#76C5A4",
    darkblue = "#568BB4",
    green = "#74C7A4",
    orange = "#E39A65",
    purple = "#AF98E6",
    magenta = "#BDA9D4",
    blue = "#8DBBD3",
    red = "#FB7DA7",
    line_fg = "#14161D",
  }
end
return M