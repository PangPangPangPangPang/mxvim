local M = {}
M.config = function()
  require("mason").setup()
  local lsp_configs = {}
  require("mason-lspconfig").setup({
    automatic_enable = true,
    ensure_installed = mxvim.lsp,
  })
  for _, f in pairs(mxvim.lsp) do
    local server_name = f
    table.insert(lsp_configs, server_name)
  end
  vim.lsp.enable(lsp_configs)
end
return M