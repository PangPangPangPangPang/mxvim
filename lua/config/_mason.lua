local M = {}
M.config = function()
	require("mason").setup()
	-- require("lsp.lsp_ts").register()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"rust_analyzer",
			"jsonls",
			"cssls",
			"html",
			"bashls",
		},
	})
	local lsp_config = require('config._lsp_config');
	local config = lsp_config.make_config()
	require("mason-lspconfig").setup_handlers({
		function(server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup(config)
		end,
		lua_ls = function()
			require("lsp.lsp_lua").setup(config)
		end
	})
	require("lsp.lsp_swift").setup()
	vim.cmd([[ LspStart ]])
end
return M