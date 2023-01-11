local M = {}
local colors = require("theme").shade_colors(0.4)
local cmd = vim.cmd

M.config = function()
    M.custom_handlers()
end
M.set_signature = function(bufnr)
    local safe_require = require("utils").safe_require
    safe_require("lsp_signature", function(lsp_signature)
        lsp_signature.on_attach({}, bufnr)
    end)
end

M.set_keymap = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Mappings.
    local opts = { noremap = false, silent = true }

    local map = require("utils").map

    if not mxvim.enable_lspsage then
        map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "<space>cn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({enable_popup=false})<CR>", opts)
        buf_set_keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({enable_popup=false})<CR>", opts)
        buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        buf_set_keymap("n", "J", "<Cmd>lua require('config._lsp_config').show_cursor_diagnostic()<CR>", opts)
    end

    map("n", "<c-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>cq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

    -- buf_set_keymap("n", "<space>cd", "<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    buf_set_keymap("n", "<space>cp", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", opts)
    buf_set_keymap("v", "<space>cp", ":'<,'>lua vim.lsp.buf.range_formatting()<CR>", opts)

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        local show_diag = "autocmd CursorHold * lua require('config._lsp_config').show_cursor_virt_diagnostic()"
        cmd([[ augroup lsp_document_highlight ]])
        cmd([[ autocmd! * <buffer> ]])
        cmd([[ autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()  ]])
        cmd([[ autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight() ]])
        cmd([[ autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references() ]])
        cmd(show_diag)
        cmd([[ autocmd CursorMoved <buffer> lua require('config._lsp_config').hide_cursor_diagnostic() ]])
        cmd([[ autocmd CursorMovedI <buffer> lua require('config._lsp_config').hide_cursor_diagnostic() ]])
        -- cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 1000)]])
        cmd([[ augroup END ]])
        cmd([[
            hi! default link DiagnosticVirtualTextError Comment
            hi! default link DiagnosticVirtualTextHint Comment
            hi! default link DiagnosticVirtualTextInfo Comment
            hi! default link DiagnosticVirtualTextWarn Comment
        ]])

        cmd(string.format(
            [[
        hi! DiagnosticDefaultInfo guifg=%s
        hi! DiagnosticUnderlineError gui=undercurl term=undercurl guisp=%s guifg=none
        hi! DiagnosticUnderlineHint gui=undercurl term=undercurl guisp=%s guifg=none
        hi! DiagnosticUnderlineWarn gui=undercurl term=undercurl guisp=%s guifg=none
        hi! DiagnosticUnderlineInfo gui=undercurl term=undercurl guisp=%s guifg=none
        hi! DiagnosticSignError gui=none guifg=%s
        hi! DiagnosticSignHint gui=none guifg=%s
        hi! DiagnosticSignWarn gui=none guifg=%s
        hi! DiagnosticSignInfo gui=none guifg=%s
        highlight! link LspReference %s
        highlight! link LspReferenceText LspReference
        highlight! link LspReferenceRead LspReference
        highlight! link LspReferenceWrite LspReference
        ]]   ,
            colors.bg,
            colors.red,
            colors.blue,
            colors.yellow,
            colors.blue,
            colors.red,
            colors.blue,
            colors.yellow,
            colors.blue,
            colors.highlight ~= nil and colors.highlight or "Visual"
        ))
    end
end

M.on_attach = function(client, bufnr)
    M.set_signature(bufnr)
    M.set_keymap(client, bufnr)
end

M.make_config = function()
    local safe_require = require("utils").safe_require
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if mxvim.use_cmp == true then
        safe_require("cmp_nvim_lsp", function(cmp)
            capabilities = cmp.default_capabilities(capabilities)
        end)
    end
    local root_dir
    safe_require("lspconfig/util", function(util)
        root_dir = util.root_pattern("package.json", ".eslintrc", ".git")
    end)
    local config = {
        autostart = true,
        root_dir = root_dir,
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = M.on_attach,
    }
    if mxvim.use_coq == true then
        safe_require("coq", function(coq)
            config = coq.lsp_ensure_capabilities(config)
        end)
    end
    return config
end

M.custom_handlers = function()
    -- local signs = {
    -- 	Error = " ",
    -- 	Warn = " ",
    -- 	Hint = " ",
    -- 	Info = " ",
    -- }
    local signs = { Warn = " ", Info = " ", Hint = " ", Error = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local safe_require = require("utils").safe_require
    safe_require("lsputil.locations", function(locations)
        vim.lsp.handlers["textDocument/references"] = locations.references_handler
        vim.lsp.handlers["textDocument/definition"] = locations.definition_handler
        vim.lsp.handlers["textDocument/declaration"] = locations.declaration_handler
        vim.lsp.handlers["textDocument/typeDefinition"] = locations.typeDefinition_handler
        vim.lsp.handlers["textDocument/implementation"] = locations.implementation_handler
    end)
    safe_require("lsputilsymbols", function(symbols)
        vim.lsp.handlers["textDocument/documentSymbol"] = symbols.document_handler
        vim.lsp.handlers["workspace/symbol"] = symbols.workspace_handler
    end)

    local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
    }
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
    vim.diagnostic.config({
        virtual_text = false,
        -- virtual_text = {
        -- 	spacing = 2,
        -- },
        signs = function()
            return true
        end,
        underline = true,
        update_in_insert = false,
        float = {
            show_header = true,
            focusable = false,
            border = "rounded",
            source = "always",
        },
    })
end

_G.show_line_diagnostics_namespace = vim.api.nvim_create_namespace("show_line_diagnostics_namespace")

M.hide_cursor_diagnostic = function()
    local namespace = _G.show_line_diagnostics_namespace
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
end

M.show_cursor_virt_diagnostic = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local lnum = pos[1] - 1
    local col = pos[2]
    local diagnostics = vim.diagnostic.get(0, { lnum = lnum })
    if vim.tbl_isempty(diagnostics) then
        return
    end
    local line_length = #vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, true)[1]
    diagnostics = vim.tbl_filter(function(d)
        return d.lnum == lnum and math.min(d.col, line_length - 1) <= col and (d.end_col >= col or d.end_lnum > lnum)
    end, diagnostics)
    if next(diagnostics) == nil then
        return
    end
    local lines = {}
    for _, diagnostic in ipairs(diagnostics) do
        local prefix = string.format("%s: ", diagnostic.source)
        local message_lines = vim.split(diagnostic.message, "\n")
        table.insert(lines, prefix .. message_lines[1])
        for j = 2, #message_lines do
            table.insert(lines, string.rep(" ", #prefix) .. message_lines[j])
        end
    end
    local namespace = _G.show_line_diagnostics_namespace

    local raw_line = ""
    for _, line in ipairs(lines) do
        raw_line = string.format("%s ■ %s", raw_line, line)
    end
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
    vim.api.nvim_buf_set_extmark(0, namespace, lnum, -1, {
        virt_text = { { raw_line, "Comment" } },
        virt_text_pos = "eol",
        hl_mode = "combine",
    })
end

M.show_cursor_diagnostic = function()
    vim.diagnostic.open_float(nil, { focusable = false, border = "rounded", scope = "cursor", source = "always" })
end

return M
