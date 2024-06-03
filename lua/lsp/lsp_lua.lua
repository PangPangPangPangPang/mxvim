local M = {}
M.setup = function()
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")
	-- Configure lua language server for neovim development
	local lsp_config = require('config._lsp_config');
	local config = lsp_config.make_config()
	local lua_settings = {
		Lua = {
			hint = {
				enable = true,
				setType = true,
			},
			codelens = {
				enable = true,
			},
			completion = {
				callSnippet = "Replace",
				postfix = ".",
				showWord = "Disable",
				workspaceWord = false,
			},
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
	require("lspconfig").lua_ls.setup(config)
end

M.lazydev = function ()
	return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Library items can be absolute paths
        -- "~/projects/my-awesome-lib",
        -- Or relative, which means they will be resolved as a plugin
        -- "LazyVim",
        -- When relative, you can also provide a path to the library in the plugin dir
        "luvit-meta/library", -- see below
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
end
return M