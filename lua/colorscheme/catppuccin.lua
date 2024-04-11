local M = {}
M.config = function()
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        -- fg = '#CDD6F4', -- light text color
        fg = '#4C4F69', -- light text color
        bg = '#2D293B', -- background color
        yellow = '#EADDA0',
        cyan = '#4EC9B0',
        darkblue = '#A4B9EF',
        green = '#B3E1A3',
        orange = '#F7C196',
        purple = '#C6AAE8',
        magenta = '#F0AFE1',
        blue = '#A4B9EF',
        red = '#E28C8C',
        line_fg = "#2D293B",
    }
end
return M