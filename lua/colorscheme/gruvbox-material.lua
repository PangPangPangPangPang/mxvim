local M = {}
M.setup = function()
    vim.cmd([[ PackerLoad gruvbox-material]])
end
M.config = function()
    vim.g.gruvbox_material_background = 'soft'
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_palette = 'original'
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        -- for galaxyline
        fg = '#ebdbb2', -- light text color
        bg = '#3c3836', -- background color
        light_fg = '#3c3836', -- text color
        light_bg = '#ebdbb2', -- light background color

        fg_green = '#b8bb26',
        yellow = '#fabd2f',
        cyan = '#8ec07c',
        darkblue = '#83a598',
        green = '#b8bb26',
        orange = '#fe8019',
        purple = '#924f79',
        magenta = '#d3869b',
        blue = '#83a598',
        red = '#fb4934'
    }
end
return M
