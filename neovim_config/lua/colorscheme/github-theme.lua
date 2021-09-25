local M = {}
M.setup = function()
    vim.cmd([[ PackerLoad github-nvim-theme ]])
end
M.config = function()
    require(mxvim.current_theme).setup({
        theme_style = 'dark',
        comment_style = 'italic',
        sidebars = {"qf", "terminal", "packer", "fugitive"},
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
        purple = colors.brightMagenta,
        magenta = colors.brightMagenta,
        blue = colors.brightBlue,
        red = colors.red,
    }

end
return M
