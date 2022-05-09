local M = {}
local config = require("config._lsp_config")
M.on_attach = function(client, bufnr)
	config.set_keymap(client, bufnr)
	config.set_signature(bufnr)
	-- client.resolved_capabilities.document_formatting = false
	-- client.resolved_capabilities.document_range_formatting = false
end
return M
