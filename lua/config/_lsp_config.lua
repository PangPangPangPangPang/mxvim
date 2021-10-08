local M = {}
local colors = require('theme').shade_colors(0.6)

M.setup = function()
    vim.defer_fn(function ()
        vim.cmd([[
        PackerLoad nvim-lspinstall
        PackerLoad lsp_signature.nvim
        PackerLoad nvim-lspconfig
        ]])
        M.custom_handlers()
    end, 500)
end
M.config = function()
    local lspinstall = require('lspinstall')
    local lspconfig = require('lspconfig')

    local function setup_servers()
        lspinstall.setup()
        -- get all installed servers
        local servers = require'lspinstall'.installed_servers()
        -- ... and add manually installed servers
        for _, server in pairs(servers) do
            local config
            -- language specific config
            if server == "efm" then
                config = require("lsp.lsp_efm").config(M.on_attach)
            else
                config = M.make_config()
                if server == "lua" then
                    config.settings = require("lsp.lsp_lua").config()
                elseif server == "typescript" then
                    config.on_attach = require("lsp.lsp_ts").on_attach
                end
            end
            lspconfig[server].setup(config)
        end
    end
    setup_servers()
    lspinstall.post_install_hook = function()
        setup_servers() -- reload installed servers
        vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
    end
end
M.set_signature = function(bufnr)
    require"lsp_signature".on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {border = "single"}
    }, bufnr)
end

M.set_keymap = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- lsp
    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<c-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
    opts)
    buf_set_keymap('n', '<space>wa',
    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr',
    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts)
    buf_set_keymap('n', '<space>D',
    '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>cq',
    '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    -- replace saga
    -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
    -- opts)
    buf_set_keymap('n', '<space>cd',
    '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>',
    opts)
    buf_set_keymap('n', '<space>c[',
    '<cmd>lua vim.diagnostic.goto_prev({enable_popup=false})<CR>', opts)
    buf_set_keymap('n', '<space>c]',
    '<cmd>lua vim.diagnostic.goto_next({enable_popup=false})<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap('n', '<space>cn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>cp",
        "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<space>cp", ":'<,'>lua vim.lsp.buf.range_formatting()<CR>",
        opts)
    end
    -- buf_set_keymap('n', '<space>cp', ':Neoformat<CR>', opts)

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        local show_diag = "autocmd CursorHold <buffer> lua vim.diagnostic.show_position_diagnostics({focusable=false,border='rounded'})"
        if packer_plugins["lspsaga.nvim"] and packer_plugins["lspsaga.nvim"].loaded then
            show_diag = "autocmd CursorHold * lua require'lspsaga.diagnostic'.show_cursor_diagnostics()"
        end
        vim.cmd(string.format([[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        %s
        " autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 1000)
        augroup END

        hi! default link DiagnosticVirtualTextError Comment
        hi! default link DiagnosticVirtualTextHint Comment
        hi! default link DiagnosticVirtualTextInfo Comment
        hi! default link DiagnosticVirtualTextWarn Comment

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
        ]], show_diag, colors.bg, colors.red, colors.blue, colors.yellow, colors.blue,
        colors.red, colors.blue, colors.yellow,
        colors.blue, colors.highlight ~= nil and
        colors.highlight or "Visual"))
    end
end

M.on_attach = function(client, bufnr)
    M.set_signature(bufnr)
    M.set_keymap(client, bufnr)
end

M.make_config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {'documentation', 'detail', 'additionalTextEdits'}
    }
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    local config = {
        root_dir = require("lspconfig/util").root_pattern("package.json",
        ".eslintrc", ".git"),
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = M.on_attach
    }
    -- local coq = require('coq')
    -- return coq.lsp_ensure_capabilities(config)
    return config
end

M.signature = function()
    local safe_require = require('utils').safe_require;
    safe_require('lsp_signature', function (lspsignature)
        lspsignature.setup {
            bind = true,
            doc_lines = 2,
            floating_window = true,
            fix_pos = false,
            hint_enable = false,
            hint_prefix = "  ", -- Panda for parameter
            hint_scheme = "String",
            transpancy = 40,
            hi_parameter = "Search",
            floating_window_above_cur_line = true,
            max_height = 22,
            max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
            handler_opts = {
                border = "shadow" -- double, single, shadow, none
            },
            zindex = 10, -- by default it will be on top of all floating windows, set to 50 send it to bottom
            padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
            shadow_blend = 36, -- if you using shadow as border use this set the opacity
            shadow_guibg = 'Black' -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'

        }
    end)
end

M.custom_handlers = function()
    local signs = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " "
    }

    local border = {
        {"╭", "FloatBorder"}, {"─", "FloatBorder"}, {"╮", "FloatBorder"},
        {"│", "FloatBorder"}, {"╯", "FloatBorder"}, {"─", "FloatBorder"},
        {"╰", "FloatBorder"}, {"│", "FloatBorder"}
    }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
    end
    local lsp = vim.lsp
    lsp.handlers["textDocument/hover"] = vim.lsp.with(
    lsp.handlers.hover,
    {border = border})
    lsp.handlers["textDocument/signatureHelp"] =
    lsp.with(vim.lsp.handlers.signature_help, {border = border})
    lsp.handlers['textDocument/publishDiagnostics'] =
    lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            spacing = 2,
        },
        signs = function ()
            return true
        end,
        underline = true,
        update_in_insert = false
    })
end

return M
