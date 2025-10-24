local M = {}
M.config = function()
  require(mxvim.current_theme).setup()
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  return {
    fg = "#e0def4",
    bg = "#26233a",
    yellow = "#f6c177",
    cyan = "#9ccfd8",
    darkblue = "#31748f",
    green = "#9ccfd8",
    orange = "#f6c177",
    purple = "#c4a7e7",
    magenta = "#eb6f92",
    blue = "#c4a7e7",
    red = "#eb6f92",
  }
end
return M
