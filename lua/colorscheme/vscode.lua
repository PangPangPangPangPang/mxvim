local M = {}
M.config = function()
  vim.g.vscode_style = vim.o.background
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  return {
    fg = "#D4D4D4", -- light text color
    bg = "#252526", -- background color
    light_fg = "#252526", -- text color
    light_bg = "#E8E8E8", -- light background color

    yellow = "#DCDCAA",
    cyan = "#4EC9B0",
    darkblue = "#223E55",
    green = "#6A9955",
    orange = "#CE9178",
    purple = "#C586C0",
    magenta = "#C586C0",
    -- blue = '#569CD6',
    blue = "#007acc",
    red = "#F44747",
  }
end
return M