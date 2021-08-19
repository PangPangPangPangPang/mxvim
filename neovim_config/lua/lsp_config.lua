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
        buf_set_keymap('n', '<space>q',
                       '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        -- buf_set_keymap('n', '<space>cd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

        -- Set some keybinds conditional on server capabilities
        -- if client.resolved_capabilities.document_formatting then
        --   buf_set_keymap("n", "<space>cp", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        -- end
        -- if client.resolved_capabilities.document_range_formatting then
        --   buf_set_keymap("v", "<space>cp", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        -- end
        buf_set_keymap('n', '<space>cp', ":Neoformat<CR>", opts)

        -- Set autocommands conditional on server_capabilities
        if client.resolved_capabilities.document_highlight then
            vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                autocmd CursorHold <buffer> lua require'lspsaga.diagnostic'.show_cursor_diagnostics()
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 1000)
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

    local eslint = {
        lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
        lintIgnoreExitCode = true,
        lintStdin = true,
        lintFormats = {"%f:%l:%c: %m"}
    }

    local languages = {
        lua = {formatCommand = "lua-format -i", formatStdin = true},
        typescript = eslint,
        typescriptreact = eslint,
        javascript = eslint,
        javascriptreact = eslint
    }

    -- lspconfig.efm.setup {
    --     -- root_dir = lspconfig.util
    --     --     .root_pattern("yarn.lock", "lerna.json", ".git"),
    --     filetypes = vim.tbl_keys(languages),
    --     init_options = {
    --         documentFormatting = true,
    --         codeAction = true,
    --         documentSymbol = true,
    --         codeAction = true,
    --         completion = true
    --     },
    --     settings = {
    --         languages = languages,
    --         verson = 2,
    --         rootMarkers = {".eslintrc.js", ".git/", "yarn.lock", "lerna.json"}
    --     },
    --     on_attach = on_attach
    -- }
    local function make_config()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = {'documentation', 'detail', 'additionalTextEdits'}
        }
        return {
            -- enable snippet support
            capabilities = capabilities,
            -- map buffer local keybindings when the language server attaches
            on_attach = on_attach,
        }
    end
    local efm_config = {
        filetypes = vim.tbl_keys(languages),
        init_options = {
            documentFormatting = true,
            documentSymbol = true,
            codeAction = true,
            completion = true
        },
        settings = {
            languages = languages,
            verson = 2,
            rootMarkers = {".eslintrc.js", ".git/", "yarn.lock", "lerna.json"}
        },
        on_attach = on_attach,
    }

    -- Configure lua language server for neovim development
    local lua_settings = {
        Lua = {
            runtime = {
                -- LuaJIT in the case of Neovim
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        }
    }

    local lspinstall = require('lspinstall')
    local function setup_servers()
        lspinstall.setup()

        -- get all installed servers
        local servers = require'lspinstall'.installed_servers()
        -- ... and add manually installed servers
        local lsps = { "vimls", "tsserver", "cssls", "html", "bashls", "jsonls", "efm", "sumneko_lua"}
        for _, lsp in pairs(lsps) do
            table.insert(servers, lsp)
        end

        for _, server in pairs(servers) do
            print(server)
            local config = make_config()

            -- language specific config
            if server == "sumneko_lua" then
                config.settings = lua_settings
            end
            if server == "efm" then
                config = efm_config
            end
            lspconfig[server].setup(config)
        end
    end
    setup_servers()
    lspinstall.post_install_hook = function ()
        setup_servers() -- reload installed servers
        vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
    end
end

M.modifyIcons = function()
    local icons = {
        Class = " פּ ",
        Color = "  ",
        Constant = "  ",
        Constructor = "  ",
        Enum = " 練",
        EnumMember = "  ",
        Field = "  ",
        File = "  ",
        Folder = " ﱮ ",
        Function = "  ",
        Interface = " 蘒",
        Keyword = "  ",
        Method = "  ",
        Module = "  ",
        Property = "  ",
        Snippet = "  ",
        Struct = "  ",
        Text = "  ",
        Unit = " 塞 ",
        Value = "  ",
        Variable = "[]"
    }
    local kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(kinds) do kinds[i] = icons[kind] or kind end
end

return M
