local M = {}
M.setup = function ()
    local g = vim.g
    g.indent_blankline_use_treesitter = true
    vim.opt.listchars = {
        space = "⋅",
        -- eol = "↴",
    }
    require("indent_blankline").setup {
        char = '│',
        buftype_exclude = {'tex', 'markdown', 'txt', 'startify', 'packer'},
        show_end_of_line = true,
        space_char_blankline = " ",
        -- show_current_context = true,
    }
end
return M

