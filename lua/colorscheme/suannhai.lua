local M = {}
M.config = function()
  require("suannhai").setup({})
  -- Formosa: suannhai-jiufen suannhai-lam-ni suannhai-hue-poo
  -- Nippon:  suannhai-rouiro suannhai-sumi suannhai-koiai suannhai-torinoko suannhai-shironeri
  vim.cmd("colorscheme suannhai-hue-poo")
end

M.colors = function()
  return {
    fg = "#D6CFC4",
    bg = "#151A21",
    yellow = "#D9A441",
    cyan = "#6FA6A8",
    darkblue = "#6FA6A8",
    green = "#7FA37A",
    orange = "#E08A50",
    purple = "#A98BB5",
    magenta = "#A98BB5",
    blue = "#6FA6A8",
    red = "#D64545",
  }
end
return M