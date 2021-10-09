local map = require('utils').map
local M = {}
M.setup = function()
    vim.defer_fn(function ()
        vim.cmd([[
            PackerLoad lspsaga.nvim
        ]])
    end, 400)
end
M.config = function()
    local opts = {noremap = true, silent = true}
    -- lspsaga
    -- buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
    map('n', '<space>cn', "<cmd>lua require('lspsaga.rename').rename()<CR>",
        opts)
    map('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",
        opts)
    map('n', '<space>cd',
        "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)
    -- map('n', '<space>c[',
    --     "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",
    --     opts)
    -- map('n', '<space>c]',
    --     "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",
    --     opts)
    -- map('n', '<space>ca',
    --     "<cmd>lua require'lspsaga.codeaction'.code_action()<CR>",
    --     opts)
    map('n', 'gd',
        "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>",
        opts)
    map('v', '<space>ca',
        ":<C-U>lua require'lspsaga.codeaction'.range_code_action()<CR>",
        opts)
    local saga = require 'lspsaga'

    saga.init_lsp_saga {
        -- add your config value here
        -- default value
        use_saga_diagnostic_sign = true,
        error_sign = '',
        warn_sign = '',
        hint_sign = '',
        infor_sign = '',
        dianostic_header_icon = '   ',
        code_action_icon = ' ',
        -- code_action_icon = '💡',
        code_action_prompt = {
            enable = false,
            sign = false,
            sign_priority = 20,
            virtual_text = true
        },
        finder_definition_icon = '  ',
        finder_reference_icon = '  ',
        max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
        finder_action_keys = {
            open = 'o',
            vsplit = 's',
            split = 'i',
            quit = 'q',
            scroll_down = '<C-f>',
            scroll_up = '<C-b>' -- quit can be a table
        },
        code_action_keys = {quit = {'<esc>', '<C-c>'}, exec = '<CR>'},
        rename_action_keys = {
            quit = {'<esc>', '<C-c>'},
            exec = '<CR>' -- quit can be a table
        },
        definition_preview_icon = '  ',
        -- "single" "double" "round" "plus"
        border_style = "single",
        rename_prompt_prefix = '➤ ',
        --[[ if you don't use nvim-lspconfig you must pass your server name and
        the related filetypes into this table ]]
        -- like server_filetype_map = {metals = {'sbt', 'scala'}}
        server_filetype_map = {}
    }
    -- vim.cmd([[
    -- augroup lsp_saga_document_highlight
    --     autocmd CursorHold * lua require'lspsaga.diagnostic'.show_cursor_diagnostics()
    -- augroup END
    -- ]])
end

return M
