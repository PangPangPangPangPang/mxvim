local M = {}
M.config = function()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "rust_analyzer",
      "jsonls",
      "cssls",
      "html",
      "bashls",
      "vtsls",
    },
  })
  local lsp_config = require("config._lsp_config")
  local config = lsp_config.make_config()
  local handler = {
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup(config)
    end,
    lua_ls = function()
      require("lsp.lsp_lua").setup()
    end,
    vtsls = function()
      require("lsp.lsp_ts").setup_vtsls()
    end,
  }
  if not mxvim.enable_ts_tools then
    handler.ts_ls = function()
      require("lsp.lsp_ts").setup()
    end
  end

  require("mason-lspconfig").setup_handlers(handler)
  require("lsp.lsp_swift").setup()
  vim.cmd([[ LspStart ]])
end
return M