local M = {}

M.config = function()
    local lspconfig = require('lspconfig')

    local signs = {
        Error = " ",
        Warning = " ",
        Hint = " ",
        Information = " "
    }

    local on_attach = function(client, bufnr)
        require"lsp_signature".on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {border = "single"}
        }, bufnr)
        for type, icon in pairs(signs) do
            local hl = "LspDiagnosticsSign" .. type
            vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
        end
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
        buf_set_keymap('n', '<c-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>',
                       opts)
        -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',
                       opts)
        buf_set_keymap('n', '<C-k>',
                       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa',
                       '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr',
                       '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
                       opts)
        buf_set_keymap('n', '<space>wl',
                       '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                       opts)
        buf_set_keymap('n', '<space>D',
                       '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        -- buf_set_keymap('n', '<space>cn', '<cmd>lua vim.lsp.buf.rename()<CR>',
        --                opts)
        buf_set_keymap('n', '<space>ca',
                       '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>cq',
                       '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        -- buf_set_keymap('n', '<space>cd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

        -- Set some keybinds conditional on server capabilities
        if client.resolved_capabilities.document_formatting then
            buf_set_keymap("n", "<space>cp",
                           "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        end
        if client.resolved_capabilities.document_range_formatting then
            buf_set_keymap("v", "=",
                           ":'<,'>lua vim.lsp.buf.range_formatting()<CR>",
                           opts)
        end
        buf_set_keymap('n', '<space>cp', ':Neoformat<CR>', opts)

        -- Set autocommands conditional on server_capabilities
        if client.resolved_capabilities.document_highlight then
            vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                autocmd CursorHold <buffer> lua require'lspsaga.diagnostic'.show_cursor_diagnostics()
                " autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 1000)
            augroup END

            hi! default link LspDiagnosticsVirtualTextError NonText
            hi! default link LspDiagnosticsVirtualTextHint NonText
            hi! default link LspDiagnosticsVirtualTextInformation NonText
            hi! default link LspDiagnosticsVirtualTextWarning NonText

            hi! LspDiagnosticsDefaultInformation guifg=#444444
            hi! LspDiagnosticsUnderlineError gui=undercurl term=undercurl guisp=#c4384b guifg=none
            hi! LspDiagnosticsUnderlineHint gui=undercurl term=undercurl guisp=#569cd6 guifg=none
            hi! LspDiagnosticsUnderlineWarning gui=undercurl term=undercurl guisp=#c4ab39 guifg=none
            hi! LspDiagnosticsUnderlineInformation gui=undercurl term=undercurl guisp=#569cd6 guifg=none
            highlight LspReference guifg=NONE guibg=#444444 guisp=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=59
            highlight! link LspReferenceText LspReference
            highlight! link LspReferenceRead LspReference
            highlight! link LspReferenceWrite LspReference
            ]], false)
        end
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                                                                  vim.lsp
                                                                      .diagnostic
                                                                      .on_publish_diagnostics,
                                                                  {
                -- Enable underline, use default values
                underline = true,
                -- Enable virtual text, override spacing to 4
                virtual_text = {spacing = 4},
                -- Disable a feature
                update_in_insert = false
            })
    end


    local function make_config()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport =
            true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = {'documentation', 'detail', 'additionalTextEdits'}
        }
        capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
        return {
            -- enable snippet support
            capabilities = capabilities,
            -- map buffer local keybindings when the language server attaches
            on_attach = on_attach
        }
    end

    local lspinstall = require('lspinstall')
    local function setup_servers()
        lspinstall.setup()

        -- get all installed servers
        local servers = require'lspinstall'.installed_servers()
        -- ... and add manually installed servers
        local lsps = {
            "vimls", "tsserver", "cssls", "html", "bashls", "jsonls", "efm",
            "sumneko_lua"
        }
        for _, lsp in pairs(lsps) do table.insert(servers, lsp) end

        for _, server in pairs(servers) do
            local config = make_config()

            -- language specific config
            if server == "sumneko_lua" then
                config.settings = require("lsp.lsp_lua").config()
            end
            if server == "efm" then config = require("lsp.lsp_efm").config() end
            lspconfig[server].setup(config)
        end
    end
    setup_servers()
    lspinstall.post_install_hook = function()
        setup_servers() -- reload installed servers
        vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
    end
end

M.lspkind = function()
    local present, lspkind = pcall(require, "lspkind")
    if present then lspkind.init() end
end

M.signature = function()
    local present, lspsignature = pcall(require, "lsp_signature")
    if present then
        lspsignature.setup {
            bind = true,
            doc_lines = 2,
            floating_window = true,
            fix_pos = true,
            hint_enable = true,
            hint_prefix = " ",
            hint_scheme = "String",
            transpancy = 20,
            use_lspsaga = false,
            hi_parameter = "Search",
            max_height = 22,
            max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
            handler_opts = {
                border = "single" -- double, single, shadow, none
            },
            zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
            padding = "" -- character to pad on left and right of signature can be ' ', or '|'  etc
        }
    end
end

return M
