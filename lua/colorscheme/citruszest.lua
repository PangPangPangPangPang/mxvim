local M = {}
M.config = function()
  require("citruszest").setup({
    option = {
      bold = true,
      italic = true,
    },
  })
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  return {
    fg = "#BFBFBF", -- light text color
    bg = "#121212", -- background color
    yellow = "#FFD700",
    cyan = "#00FFFF",
    darkblue = "#00BFFF",
    green = "#00CC7A",
    orange = "#FF7431",
    purple = "#FF1A75",
    magenta = "#FF1A75",
    blue = "#00BFFF",
    red = "#FF5454",
    line_fg = "#121212",
  }
end
return M