local M = {}
M.config = function ()
    require(vim.g.current_theme).setup()
end

M.colors = {
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
    blue = '#252526',
    red = '#F44747'
}
return M
