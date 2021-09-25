local M = {}
M.setup = function()
    vim.cmd([[ PackerLoad vscode.nvim]])
end
M.config = function()
    vim.g.vscode_style = "dark"
    vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
    return {
        bg = '#252526',
        line_bg = '#252526',
        fg = '#9CDCFE',
        fg_green = '#B5CEA8',
        yellow = '#DCDCAA',
        cyan = '#4EC9B0',
        darkblue = '#223E55',
        green = '#6A9955',
        orange = '#CE9178',
        purple = '#C586C0',
        magenta = '#C586C0',
        blue = '#569CD6',
        red = '#F44747'
    }

end
return M
