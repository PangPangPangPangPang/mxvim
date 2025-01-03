local M = {}
M.config = function()
  mxvim.background = "light"
  require("newpaper").setup({
    sidebars_contrast = { "NvimTree" },
    colors = {
      lightsilver = "#F1F3F2",
    },
    custom_highlights = {
      WinSeparator = { fg = "#DFE4EB", bg = "none" },
      LineNr = mxvim.enable_cursor and { fg = "#878787", bg = "none" } or nil,
    },
  })
end

M.colors = function()
  return {
    fg = "#F1F3F2", -- light text color
    bg = "#2B2B2B", -- background color
    yellow = "#D75F00",
    cyan = "#0087AF",
    darkblue = "#0072C1",
    green = "#50A14F",
    orange = "#D75F00",
    purple = "#8700AF",
    magenta = "#E563BA",
    blue = "#0072C1",
    red = "#E14133",
    line_fg = "#2B2B2B",
    line_bg = "#DFE4EB",
  }
end
return M