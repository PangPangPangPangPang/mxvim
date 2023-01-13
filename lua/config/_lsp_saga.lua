local map = require("utils").map
local M = {}
M.setup = function()
    vim.defer_fn(function()
        vim.cmd([[
            PackerLoad lspsaga.nvim
        ]])
    end, 400)
end
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
        code_action_lightbulb = {
            enable = false,
            sign = true,
            enable_in_insert = true,
            sign_priority = 20,
            virtual_text = true,
        },
        symbol_in_winbar = {
            enable = vim.fn.has("nvim-0.8") == 1,
            separator = '  ',
            hide_keyword = true,
            show_file = true,
            folder_level = 2,
        },
        ui = {
            theme = 'round',
            border = 'solid',
            winblend = 0,
            expand = '',
            collaspe = '',
            preview = ' ',
            code_action = '💡',
            diagnostic = '🐞',
            incoming = ' ',
            outgoing = ' ',
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
    keymap("n", "<F2>", "<cmd>LSoutlineToggle<CR>", { silent = true })

    -- Hover Doc
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

    -- Signature help
    keymap("n", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", { silent = true })
end

return M
