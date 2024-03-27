local M = {}
M.config = function()
    -- base / moon / dawn
    vim.g.rose_pine_variant = 'moon'
    vim.g.rose_pine_disable_italics = false
    vim.g.rose_pine_disable_background = false
    vim.g.rose_pine_bold_vertical_split_line = true
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        fg = '#e0def4',
        bg = '#26233a',
        light_fg = '#26233a',
        light_bg = '#e0def4',
        fg_green = '#9ccfd8',
        yellow = '#f6c177',
        cyan = '#9ccfd8',
        darkblue = '#31748f',
        green = '#9ccfd8',
        orange = '#f6c177',
        purple = '#c4a7e7',
        magenta = '#eb6f92',
        blue = '#c4a7e7',
        red = '#eb6f92'
    }

end
return M