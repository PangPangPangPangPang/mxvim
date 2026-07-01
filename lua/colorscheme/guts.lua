local M = {}
M.config = function()
  vim.cmd.colorscheme("guts")
end

M.colors = function()
  return {
    fg = "#9f9e99",       -- dragon_slayer_white
    bg = "#101113",       -- rainy_night_black_1
    yellow = "#ac7f7b",   -- campfire (no true yellow in palette)
    cyan = "#8288a0",     -- snow_gray
    darkblue = "#546c9a", -- night_sky_blue_raw
    green = "#a7d8b0",    -- brand_of_sacrifice_green_1
    orange = "#b84e1f",   -- campfire_raw
    purple = "#83799c",   -- griffith_purple
    magenta = "#af6ea6",  -- eclipse_pink_raw
    blue = "#697a9a",     -- night_sky_blue
    red = "#94484f",      -- casca_pink_raw
    line_fg = "#101113",
  }
end
return M
