local M = {}
M.config = function()
  local config = require("config._lsp_config").make_config()
  local null_ls = require("null-ls")
	null_ls.register(require("none-ls-luacheck.diagnostics.luacheck"))
  -- pip3 install codespell
  -- yarn global add eslint_d
  -- luarocks install luacheck
  local prettier = null_ls.builtins.formatting.prettier
  prettier.filetypes = { "css", "scss", "html", "json", "yaml", "markdown" }

  local sources = {
    null_ls.builtins.diagnostics.codespell,
    -- null_ls.builtins.diagnostics.selene,
    null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.code_actions.gitsigns,
    prettier,
  }
  null_ls.setup({ sources = sources, debug = false })
  local safe_require = require("utils").safe_require
  safe_require("lspconfig.config", function(lspconfig)
    lspconfig["null-ls"].setup(config)
  end)
  require("mason-null-ls").setup({
    ensure_installed = nil,
    automatic_installation = true,
  })
end
return M