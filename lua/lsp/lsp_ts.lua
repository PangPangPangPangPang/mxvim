if not mxvim.enable_ts_tools then
  return
end
return {
  "pmizio/typescript-tools.nvim",
  event = {
    "BufRead *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx",
    "BufNewFile *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

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
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}