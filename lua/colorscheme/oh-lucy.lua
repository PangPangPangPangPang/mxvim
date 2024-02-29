local M = {}
M.config = function()
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  return {
    fg = "#E9E9E9",
    bg = "#14161D",
    light_bg = "#E9E9E9",
    light_fg = "#14161D",

    fg_green = "#76C5A4",
    yellow = "#E3CF65",
    cyan = "#76C5A4",
    darkblue = "#568BB4",
    green = "#76C5A4",
    orange = "#E39A65",
    purple = "#AF98E6",
    magenta = "#BDA9D4",
    blue = "#8DBBD3",
    red = "#FB7DA7",
    line_fg = "#14161D",
  }
end
return M