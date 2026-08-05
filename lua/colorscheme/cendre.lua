local M = {}
M.config = function()
  require("cendre").setup({
    background = "hard", -- "hard" | "medium" | "soft"
    italic_virtual_text = false,
  })
  vim.cmd.colorscheme("cendre")
end

M.colors = function()
  return {
    fg = "#e6d5c2",
    bg = "#171311",
    yellow = "#fcba81", -- brass
    cyan = "#20c9cb", -- hint
    darkblue = "#4e89a2", -- frost
    green = "#99af6b", -- sap
    orange = "#ea9875", -- ember
    purple = "#9480ba", -- potassium
    magenta = "#d25780", -- error
    blue = "#4e89a2", -- frost
    red = "#d1766e", -- cinder
    line_fg = "#171311",
  }
end
return M
