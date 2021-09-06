local M = {}
M.config = function()
    require(vim.g.current_theme).setup({
        themeStyle = 'dark',
        commentStyle = 'italic'
    })
end

M.colors = function()
    local configModule = require("github-theme.config")
    local config = configModule.config
    local colors = require("github-theme.colors").setup(config)
    return {
        bg = colors.bg2,
        line_bg = colors.bg2,
        fg = colors.fg,
        fg_green = colors.green,
        yellow = colors.yellow,
        cyan = colors.cyan,
        darkblue = colors.blue,
        green = colors.green,
        orange = colors.orange,
        purple = colors.magenta,
        magenta = colors.magenta,
        blue = colors.brightBlue,
        red = colors.red
    }

end
return M
