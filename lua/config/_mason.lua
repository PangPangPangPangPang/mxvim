local M = {}
M.config = function()
  require("mason").setup()
  local lsp_configs = {}
  for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
    local server_name = vim.fn.fnamemodify(f, ":t:r")
    local cmd = dofile(f).cmd[1]
    if vim.fn.executable(cmd) == 0 then
      vim.cmd("MasonInstall " .. name)
    end
    table.insert(lsp_configs, server_name)
  end
  vim.lsp.enable(lsp_configs)
  -- require("mason-lspconfig").setup({
  -- 	automatic_enable = true,
  -- 	ensure_installed = {
  -- 		"rust_analyzer",
  -- 		"jsonls",
  -- 		"cssls",
  -- 		"html",
  -- 		"bashls",
  -- 		"vtsls",
  -- 	},
  -- })
end
return M
