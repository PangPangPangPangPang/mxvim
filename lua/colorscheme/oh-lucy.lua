local M = {}
M.config = function()
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        fg = '#4C4F69', -- light text color
        bg = '#2D293B', -- background color
        light_fg = '#2D293B', -- text color
        light_bg = '#C2E7F0', -- light background color

        fg_green = '#B3E1A3',
        yellow = '#EADDA0',
        cyan = '#4EC9B0',
        darkblue = '#A4B9EF',
        green = '#B3E1A3',
        orange = '#F7C196',
        purple = '#C6AAE8',
        magenta = '#F0AFE1',
        blue = '#A4B9EF',
        red = '#E28C8C'
    }
end
return M
