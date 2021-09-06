local M = {}
M.setup = function ()
    local g = vim.g
    g.indent_blankline_use_treesitter = false
    g.indent_blankline_context_patterns = {
        "declaration", "expression", "pattern", "primary_expression",
        "statement", "switch_body"
    }
    require("indent_blankline").setup {
        char = '│',
        buftype_exclude = {'tex', 'markdown', 'txt', 'startify', 'packer'},
        show_end_of_line = true,
        space_char_blankline = " ",
        -- show_current_context = true,
    }
end
M.setupIndent = function()
    local g = vim.g
    g.indentLine_char = '▏'
end

return M

