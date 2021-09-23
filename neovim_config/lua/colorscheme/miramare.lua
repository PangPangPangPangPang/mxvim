local M = {}
M.setup = function()
    vim.cmd([[ PackerLoad miramare ]])
end
M.config = function() vim.cmd('colorscheme ' .. vim.g.current_theme) end

M.colors = function()
    return {
        bg = '#242021',
        line_bg = '#242021',
        fg = '#e6d6ac',
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
