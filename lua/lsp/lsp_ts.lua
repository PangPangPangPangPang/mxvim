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
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true
      vim.keymap.set(
        "n",
        "<leader>cs",
        "<Cmd>TSToolsOrganizeImports<CR>",
        { buffer = bufnr, desc = "Organize imports" }
      )
      -- vim.api.nvim_set_hl(0, "@lsp.mod.readonly.typescriptreact", { link = "@variable" })
      -- vim.api.nvim_set_hl(0, "@lsp.typemod.variable.declaration.typescriptreact", { link = "@variable" })
      -- vim.api.nvim_set_hl(0, "@variable.member.tsx", { link = "@property" })
    end,
    handlers = {
      ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
        vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
      end,
    },
    settings = {
      publish_diagnostic_on = "change",
      -- expose_as_code_action = "all",
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
    },
  },
}