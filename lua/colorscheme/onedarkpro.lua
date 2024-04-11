local M = {}
M.config = function()
    local onedark = require('onedarkpro')
    onedark.setup({
        theme = 'onedark', -- Or
        -- theme = 'onelight'
        styles = {
            comments = "italic",
            functions = "NONE",
            keywords = "bold,italic",
            strings = "italic",
            variables = "NONE"
        },
        colors = {
            bg = '#282c34'
        },
        hlgroups = {
            CursorLine = { bg = '#4b4b4b' },
            NvimTreeNormalNC = { bg = '#21252b' },
            NvimTreeNormal = { bg = '#21252b' },
            NvimTreeSignColumn = { bg = '#21252b' }
        }
    })
    onedark.load()
end

M.colors = function()
    return {
        -- bg = '#1E1E1E', -- background color
        fg = '#abb2bf', -- light text color
        bg = '#21252b', -- background color
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