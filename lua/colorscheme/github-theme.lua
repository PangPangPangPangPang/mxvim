local M = {}
M.setup = function()
    vim.cmd([[ PackerLoad github-nvim-theme ]])
end
M.config = function()
    require(mxvim.current_theme).setup({
        theme_style = 'dark',
        comment_style = 'italic',
        sidebars = {"qf", "terminal", "packer", "fugitive"},
    })
end

M.colors = function()
    return {
        fg = '#e1e4e8',
        bg = '#2c2b1c',
        light_fg = '#2c2b1c',
        light_bg = 'e1e4e8',
        fg_green = '#85e89d',
        yellow = '#e3b341',
        cyan = '#fdaeb7',
        darkblue = '#3b8eea',
        green = '#23d18b',
        orange = '#d18616',
        purple = '#b392f0',
        magenta = '#f97583',
        blue = '#3b8eea',
        red = '#f14c4c'
    }
end
return M
