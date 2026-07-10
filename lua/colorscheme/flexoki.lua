local M = {}
M.config = function()
  mxvim.background = "light"
  vim.o.background = "light"
  require("flexoki").setup({
    theme = "light",
  })
  vim.cmd([[colorscheme flexoki]])
end

M.colors = function()
  return {
    fg = "#FFFCF0", -- light text color (flexoki paper)
    bg = "#100F0F", -- background color (flexoki black)
    yellow = "#AD8301",
    cyan = "#24837B",
    darkblue = "#205EA6",
    green = "#66800B",
    orange = "#BC5215",
    purple = "#5E409D",
    magenta = "#A02F6F",
    blue = "#205EA6",
    red = "#AF3029",
    line_fg = "#100F0F",
    line_bg = "#E6E4D9",
  }
end
return M
