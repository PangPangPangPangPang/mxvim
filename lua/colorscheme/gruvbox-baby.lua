local M = {}
M.config = function()
    -- Example config in Lua
    vim.g.gruvbox_baby_function_style = "NONE"
    vim.g.gruvbox_baby_keyword_style = "italic"

    -- Each highlight group must follow the structure:
    -- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
    -- See also :h highlight-guifg
    -- Example:

    -- Enable telescope theme
    vim.g.gruvbox_baby_telescope_theme = 0

    -- Enable transparent mode
    vim.g.gruvbox_baby_transparent_mode = 0
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        fg = '#ebdbb2', -- light text color
        bg = '#3c3836', -- background color
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