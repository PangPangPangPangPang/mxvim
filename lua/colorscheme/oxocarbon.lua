local M = {}
M.config = function()
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        -- for galaxyline
        -- bg = '#1E1E1E', -- background color
        -- light_fg = '#1E1E1E', -- text color
        fg = '#abb2bf', -- light text color
        bg = '#21252b', -- background color
        light_fg = '#21252b', -- text color
        light_bg = '#abb2bf', -- light background color

        fg_green = '#98C379',
        yellow = '#ecbf6f',
        cyan = '#56b6c2',
        darkblue = '#223E55',
        green = '#98C379',
        orange = '#CE9178',
        purple = '#c678dd',
        magenta = '#C586C0',
        blue = '#61afef',
        red = '#e06c75'
    }

end
return M