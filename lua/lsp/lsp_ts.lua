local M = {}
local lsp_config = require("config._lsp_config")
M.modify = function(config)
	config.on_attach = function(client, bufnr)
		lsp_config.set_keymap(client, bufnr)
		lsp_config.set_signature(bufnr)
	end
end

M.register = function()
	local mason_registry = require('mason-registry')
	local tsserver_path = mason_registry.get_package('typescript-language-server'):get_install_path()
	require("typescript-tools").setup({
		settings = {
			tsserver_path = tsserver_path .. '/node_modules/typescript/lib/tsserver.js',
		}
	})
end

M.config = function()
	local config = lsp_config.make_config()
	require("typescript-tools").setup {
		on_attach = require("config._lsp_config").on_attach
	}
end
return M