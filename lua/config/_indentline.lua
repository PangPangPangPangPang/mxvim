local M = {}
M.setup = function ()
    local g = vim.g
    g.indent_blankline_use_treesitter = false
    g.indent_blankline_context_patterns = {
        "declaration", "expression", "pattern", "primary_expression",
        "statement", "switch_body"
    }
    local colors = require('theme').shade_colors_default()
    local commonColors = require('theme').theme_colors()
    local indent1 = string.format('hi! IndentBlanklineIndent1 guifg=%s blend=nocombine', colors.red);
    local indent2 = string.format('hi! IndentBlanklineIndent2 guifg=%s blend=nocombine', colors.yellow);
    local indent3 = string.format('hi! IndentBlanklineIndent3 guifg=%s blend=nocombine', colors.green);
    local indent4 = string.format('hi! IndentBlanklineIndent4 guifg=%s blend=nocombine', colors.cyan);
    local indent5 = string.format('hi! IndentBlanklineIndent5 guifg=%s blend=nocombine', colors.blue);
    local indent6 = string.format('hi! IndentBlanklineIndent6 guifg=%s blend=nocombine', colors.purple);
    local contextChar = string.format('hi! IndentBlanklineContextChar guifg=%s blend=nocombine', commonColors.purple);
    local contextStart = string.format('hi! IndentBlanklineContextStart gui=underline term=underline guisp=%s', commonColors.purple);
    vim.cmd(string.format([[
        augroup IndentBlankline
            %s
            %s
            %s
            %s
            %s
            %s
            %s
            %s
        augroup End
    ]], indent1, indent2, indent3, indent4, indent5, indent6, contextChar, contextStart))
    vim.cmd [[
    ]]
    require("indent_blankline").setup {
        char = '▏',
        context_char = '▏',
        buftype_exclude = {'tex', 'markdown', 'txt', 'startify', 'packer', 'terminal'},
        filetype_exclude = {'NvimTree', 'TelescopePrompt', 'mason'},
        show_end_of_line = true,
        char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        },
        space_char_blankline = " ",
        show_current_context = mxvim.enable_treesitter,
        show_current_context_start = mxvim.enable_treesitter,
    }
end
M.setupIndent = function()
    local g = vim.g
    g.indentLine_char = '▏'
end

return M
