local M = {}
M.config = function()
  vim.g.nord_contrast = true
  vim.g.nord_enable_sidebar_background = true
  vim.g.nord_borders = true
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  local colors = require("nord.colors")
  return {
    fg = colors.nord5_gui,
    bg = colors.nord1_gui,
    yellow = colors.nord13_gui,
    cyan = colors.nord8_gui,
    darkblue = colors.nord10_gui,
    green = colors.nord14_gui,
    orange = colors.nord12_gui,
    purple = colors.nord15_gui,
    magenta = colors.nord15_gui,
    blue = colors.nord9_gui,
    red = colors.nord11_gui,
  }
end

return M
