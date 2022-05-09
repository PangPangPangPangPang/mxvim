local M = {}
M.modify = function(config)
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")
	-- Configure lua language server for neovim development
	local lua_settings = {
		Lua = {
			runtime = {
				-- LuaJIT in the case of Neovim
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "packer_bootstrap", "packer_plugins" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	}
    config.settings = lua_settings
end
return M
