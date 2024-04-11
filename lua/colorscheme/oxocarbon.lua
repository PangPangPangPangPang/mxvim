local M = {}
M.config = function()
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        -- bg = '#1E1E1E', -- background color
        fg = '#D0D0D0', -- light text color
        bg = '#161616', -- background color

        yellow = '#FFD702',
        cyan = '#3DDBD9',
        darkblue = '#65799B',
        green = '#8CFF48',
        orange = '#E7A27E',
        purple = '#EE5396',
        magenta = '#FF7EB6',
        blue = '#78A9FF',
        red = '#EE5396'
    }

end
return M