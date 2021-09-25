local M = {}
M.setup = function()
    vim.cmd([[ PackerLoad vim-nightfly-guicolors]])
end
M.config = function()
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        fg = '#acb4c2',
        bg = '#011627',
        light_fg = '#011627',
        light_bg = '#acb4c2',
        fg_green = '#7fdbca',
        yellow = '#e3d18a',
        cyan = '#21c7a8',
        darkblue = '#82aaff',
        green = '#a1cd5e',
        orange = '#ecc48d',
        purple = '#ae81ff',
        magenta = '#ff5874',
        blue = '#82aaff',
        red = '#fc514e'
    }

end
return M
