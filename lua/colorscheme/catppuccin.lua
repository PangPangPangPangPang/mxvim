local M = {}
M.config = function()
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
  if mxvim.background == "dark" then
    return {
      fg = "#4C4F69", -- light text color
      bg = "#2D293B", -- background color
      yellow = "#EADDA0",
      cyan = "#4EC9B0",
      darkblue = "#A4B9EF",
      green = "#B3E1A3",
      orange = "#F7C196",
      purple = "#C6AAE8",
      magenta = "#F0AFE1",
      blue = "#A4B9EF",
      red = "#E28C8C",
      line_fg = "#2D293B",
    }
  else
    return {
      fg = "#eff1f5",
      bg = "#5c5f77",
      yellow = "#df8e1d",
      cyan = "#04a5e5",
      darkblue = "#1e66f5",
      green = "#40a02b",
      orange = "#fe640b",
      purple = "#8839ef",
      magenta = "#ea76cb",
      blue = "#1e66f5",
      red = "#d20f39",
      line_fg = "#5c5f77",
    }
  end
end
return M