local M = {}
M.setup = function ()
    local g = vim.g
    g.indent_blankline_use_treesitter = false
    g.indent_blankline_context_patterns = {
        "declaration", "expression", "pattern", "primary_expression",
        "statement", "switch_body"
    }
    local colors = require('theme').theme_colors()
    local shade = require("theme").shade;
    local percent = 0.4;
    local indent1 = string.format('hi! IndentBlanklineIndent1 guifg=%s blend=nocombine', shade(colors.red, percent));
    local indent2 = string.format('hi! IndentBlanklineIndent2 guifg=%s blend=nocombine', shade(colors.yellow, percent));
    local indent3 = string.format('hi! IndentBlanklineIndent3 guifg=%s blend=nocombine', shade(colors.green, percent));
    local indent4 = string.format('hi! IndentBlanklineIndent4 guifg=%s blend=nocombine', shade(colors.cyan, percent));
    local indent5 = string.format('hi! IndentBlanklineIndent5 guifg=%s blend=nocombine', shade(colors.blue, percent));
    local indent6 = string.format('hi! IndentBlanklineIndent6 guifg=%s blend=nocombine', shade(colors.purple, percent));
    vim.cmd(string.format([[
        augroup IndentBlankline
            %s
            %s
            %s
            %s
            %s
            %s
        augroup End
    ]], indent1, indent2, indent3, indent4, indent5, indent6))
    require("indent_blankline").setup {
        char = '│',
        buftype_exclude = {'tex', 'markdown', 'txt', 'startify', 'packer'},
        show_end_of_line = true,
        space_char_blankline = " ",
        char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        },
        -- show_current_context = true,
    }
end
M.setupIndent = function()
    local g = vim.g
    g.indentLine_char = '▏'
end

return M

