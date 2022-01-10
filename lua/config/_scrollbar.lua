local M = {}
M.setup = function()
    vim.defer_fn(function ()
        vim.cmd([[
            " PackerLoad nvim-scrollbar
        ]])
    end, 1000)
end
M.config = function ()
    local colors = require("theme").shade_colors(0.6)
    require("scrollbar").setup({
    handle = {
        text = " ",
        color = colors.bg,
        hide_if_all_visible = true, -- Hides handle if all lines are visible
    },
    marks = {
        Search = { text = { "-", "=" }, priority = 0, color = colors.orange },
        Error = { text = { "-", "=" }, priority = 1, color = colors.red },
        Warn = { text = { "-", "=" }, priority = 2, color = colors.yellow },
        Info = { text = { "-", "=" }, priority = 3, color = colors.blue },
        Hint = { text = { "-", "=" }, priority = 4, color = colors.green },
        Misc = { text = { "-", "=" }, priority = 5, color = colors.purple },
    },
    excluded_filetypes = {
        "",
        "prompt",
        "TelescopePrompt",
    },
    autocmd = {
        render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
        },
    },
    handlers = {
        diagnostic = true,
        search = false,
    },
})
end
return M
