local M = {}
M.setup = function()
	vim.defer_fn(function()
		vim.cmd([[
        PackerLoad popfix
        PackerLoad nvim-lsputils
        PackerLoad lsp_signature.nvim
        PackerLoad nvim-lspconfig
        PackerLoad nvim-lsp-installer
        ]])
        M.boot();
	end, 300)
end
M.config = function()
    local lsp_config = require('config._lsp_config');
	local lsp_installer = require("nvim-lsp-installer")
	lsp_installer.on_server_ready(function(server)
		local config
		-- language specific config
		if server.name == "efm" then
			config = require("lsp.lsp_efm").config(lsp_config.on_attach)
		else
			config = lsp_config.make_config()
			if server.name == "sumneko_lua" then
				config.settings = require("lsp.lsp_lua").config()
			elseif server.name == "tsserver" then
				config.on_attach = require("lsp.lsp_ts").on_attach
			end
		end
		server:setup(config)
		vim.cmd([[ do User LspAttachBuffers ]])
	end)
end

M.boot = function()
	local desired_servers = {
		'sumneko_lua',
		'tsserver',
		'jsonls',
		'cssls',
		'html',
		'bashls',
	}
	local lsp_installer = require("nvim-lsp-installer")
	for _, server_name in pairs(desired_servers) do
		local ok, server = lsp_installer.get_server(server_name)
		if ok then
			if not server:is_installed() then
				server:install()
			end
		end
	end
end
return M
