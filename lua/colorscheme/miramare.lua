local M = {}
M.config = function() vim.cmd('colorscheme ' .. mxvim.current_theme) end

M.colors = function()
    return {
        fg = '#e6d6ac',
        bg = '#242021',
        light_fg = '#242021',
        light_bg = '#e6d6ac',
        fg_green = '#87c095',
        yellow = '#d9bb80',
        cyan = '#87c095',
        darkblue = '#203a41',
        green = '#a7c080',
        orange = '#e39b7b',
        purple = '#d3a0bc',
        magenta = '#d3a0bc',
        blue = '#89beba',
        red = '#e68183',
        highlight = 'PmenuThumb'
    }
end
return M
