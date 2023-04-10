local map = require("utils").map
local M = {}
M.config = function()
    local keymap = vim.keymap.set
    local saga = require("lspsaga")
    local colors = require("theme").theme_colors()

    saga.setup({
        finder_action_keys = {
            open = "<CR>",
            vsplit = "s",
            split = "i",
            tabe = "t",
            quit = "<esc>",
            scroll_down = "<C-f>",
            scroll_up = "<C-b>", -- quit can be a table
        },
        lightbulb = {
            enable = false,
            sign = true,
            enable_in_insert = true,
            sign_priority = 20,
            virtual_text = true,
        },
        diagnostic = {
            show_code_action = false,
            show_source = true,
            jump_num_shortcut = true,
            --1 is max
            max_width = 0.7,
            custom_fix = nil,
            custom_msg = nil,
            text_hl_follow = false,
            border_follow = true,
            keys = {
                exec_action = "o",
                quit = "q",
                go_action = "g",
            },
        },
        symbol_in_winbar = {
            -- enable = vim.fn.has("nvim-0.8") == 1,
            enable = false,
            separator = '  ',
            hide_keyword = true,
            show_file = true,
            folder_level = 2,
        },
        ui = {
            title = true,
            -- Border type can be single, double, rounded, solid, shadow.
            border = "rounded",
            winblend = 0,
            expand = "",
            collapse = "",
            code_action = "💡",
            incoming = " ",
            outgoing = " ",
            hover = ' ',
            colors = {
                --float window normal bakcground color
                normal_bg = colors.bg,
                --title background color
                title_bg = colors.green,
                red = colors.red,
                magenta = colors.magenta,
                orange = colors.orange,
                yellow = colors.yellow,
                green = colors.green,
                cyan = colors.cyan,
                blue = colors.blue,
                purple = colors.purple,
                white = colors.fg,
                black = colors.bg,
            },
            kind = {},
        },
    })

    -- Lsp finder find the symbol definition implmement reference
    -- keymap("n", "<c-]>", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

    -- Code action
    keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
    keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })

    -- Rename
    keymap("n", "<space>cn", "<cmd>Lspsaga rename<CR>", { silent = true })

    -- Definition preview
    keymap("n", "gh", "<cmd>Lspsaga preview_definition<CR>", { silent = true })

    -- Show line diagnostics
    -- keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

    -- Show cursor diagnostic
    keymap("n", "J", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

    -- Diagnsotic jump
    keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
    keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })

    -- Only jump to error
    keymap("n", "[E", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, {
        silent = true,
    })
    keymap("n", "]E", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, {
        silent = true,
    })

    -- Outline
    keymap("n", "<F2>", "<cmd>Lspsaga outline<CR>", { silent = true })

    -- Hover Doc
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

    -- Signature help
    keymap("n", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", { silent = true })
end

return M
