return {
  "pmizio/typescript-tools.nvim",
	enabled = mxvim.enable_ts_tools,
  event = {
    "BufRead *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx",
    "BufNewFile *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
    {
      "dmmulroy/ts-error-translator.nvim",
      config = function()
        require("ts-error-translator").setup()
      end,
    },
  },
  opts = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
        vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
      end

      vim.keymap.set("n", "gD", "<Cmd>TSToolsGoToSourceDefinition<CR>", { buffer = bufnr, desc = "Source Definition" })

      vim.keymap.set(
        "n",
        "<leader>cI",
        "<Cmd>TSToolsAddMissingImports<CR>",
        { buffer = bufnr, desc = "Add missing imports" }
      )
      vim.keymap.set(
        "n",
        "<leader>co",
        "<Cmd>TSToolsOrganizeImports<CR>",
        { buffer = bufnr, desc = "Organize imports" }
      )
      vim.keymap.set("n", "<leader>cf", "<Cmd>TSToolsFixAll<CR>", { buffer = bufnr, desc = "Fix all" })
    end,
    settings = {
      expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },

      tsserver_file_preferences = {
        includeCompletionsForModuleExports = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        quotePreference = "auto",
      },
      handlers = {
        ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
          require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
          vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
      },
    },
  },
}