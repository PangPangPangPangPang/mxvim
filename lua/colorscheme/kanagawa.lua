local M = {}
M.config = function()
    vim.opt.fillchars:append({
        horiz = "━",
        horizup = "┻",
        horizdown = "┳",
        vert = "┃",
        vertleft = "┨",
        vertright = "┣",
        verthoriz = "╋",
    })
    require('kanagawa').setup({
        compile = true, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {
                ui = {
                    bg_gutter = "none"
                }
            } },
        },
        overrides = function(colors) -- add/modify highlights
            return {
                VertSplit = { fg = "#D27E99", bg = "NONE" },
                LineNr = { bg = "NONE" },
            }
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
            dark = "wave", -- try "dragon" !
            light = "lotus"
        },
    })
    vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
    return {
        fg = "#DCD7BA",
        bg = "#16161D",
        light_fb = "#717C7C",
        light_bg = "#1F1F28",
        fg_green = "#76946A",
        yellow = "#E6C384",
        cyan = "#7AA89F",
        darkblue = "#658594",
        green = "#98BB6C",
        orange = "#FFA066",
        purple = "#957FB8",
        magenta = "#D27E99",
        blue = "#7E9CD8",
        red = "#FF5D62",
        line_fg = "#16161D",
    }
end
return M
