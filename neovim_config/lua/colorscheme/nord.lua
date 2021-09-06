local M = {}
M.config = function() vim.cmd('colorscheme ' .. vim.g.current_theme) end

M.colors = function()
    local colors = require('nord.colors')
    return {
        bg = colors.nord1_gui,
        line_bg = colors.nord1_gui,
        fg = colors.nord5_gui,
        fg_green = colors.nord14_gui,
        yellow = colors.nord13_gui,
        cyan = colors.nord8_gui,
        darkblue = colors.nord10_gui,
        green = colors.nord14_gui,
        orange = colors.nord12_gui,
        purple = colors.nord15_gui,
        magenta = colors.nord15_gui,
        blue = colors.nord9_gui,
        red = colors.nord11_gui
    }
end
return M
