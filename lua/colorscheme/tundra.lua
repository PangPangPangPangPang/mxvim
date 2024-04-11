local M = {}
M.config = function()
    require('nvim-tundra').setup({
        transparent_background = false,
        editor = {
            search = {},
            substitute = {},
        },
        syntax = {
            booleans = { bold = true, italic = true },
            comments = { bold = true, italic = true },
            conditionals = {},
            constants = { bold = true },
            functions = {},
            keywords = {},
            loops = {},
            numbers = { bold = true },
            operators = { bold = true },
            punctuation = {},
            strings = {},
            types = { italic = true },
        },
        diagnostics = {
            errors = {},
            warnings = {},
            information = {},
            hints = {},
        },
        plugins = {
            lsp = true,
            treesitter = mxvim.enable_treesitter,
            cmp = true,
            context = true,
            dbui = true,
            gitsigns = true,
            telescope = true,
        },
        overwrite = {
            colors = {},
            highlights = {},
        },
    })

    vim.opt.background = 'dark'
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        fg = '#e0def4',
        bg = '#26233a',
        light_fg = '#26233a',
        light_bg = '#e0def4',
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