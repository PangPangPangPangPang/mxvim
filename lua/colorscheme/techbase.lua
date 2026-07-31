local M = {}
M.config = function()
  require("techbase").setup({
    italic_comments = false,
    transparent = false,
  })
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  return {
    fg = "#CCD5E5",
    bg = "#191d23",
    yellow = "#E9B872",
    cyan = "#74BAA8",
    darkblue = "#A9B9EF",
    green = "#0EC256",
    orange = "#FFA630",
    purple = "#BCB6EC",
    magenta = "#BCB6EC",
    blue = "#6A8BE3",
    red = "#F71735",
  }
end
return M
