local M = {}
M.config = function()
    require("monokai-pro").setup({
        transparent_background = false,
        terminal_colors = true,
        devicons = true, -- highlight the icons of `nvim-web-devicons`
        italic_comments = true,
        filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
        -- Enable this will disable filter option
        day_night = {
            enable = false, -- turn off by default
            day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
            night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
        },
        inc_search = "background", -- underline | background
        background_clear = {
            -- "float_win",
            "toggleterm",
            "telescope",
            "which-key",
            "renamer"
        }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree"
        plugins = {
            bufferline = {
                underline_selected = false,
                underline_visible = false,
            },
            indent_blankline = {
                context_highlight = "default", -- default | pro
                context_start_underline = false,
            },
        },
        override = function(c) end,
    })
    vim.cmd([[colorscheme monokai-pro]])

end

M.colors = function()
    return {
        fg = '#fcfcfa', -- light text color
        bg = '#2d2a2e', -- background color
        light_fg = '#2d2a2e', -- text color
        light_bg = '#fcfcfa', -- light background color

        yellow = '#ffd866',
        cyan = '#a9dc76',
        darkblue = '#78dce8',
        green = '#a9dc76',
        orange = '#fc9867',
        purple = '#ab9df2',
        magenta = '#ff6188',
        blue = '#78dce8',
        red = '#ff6188',
        line_fg = "#2d2a2e",
    }

end
return M