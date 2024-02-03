local M = {}
M.config = function()
	local config = require("config._lsp_config").make_config()
	local null_ls = require("null-ls")
	-- pip3 install codespell
	-- yarn global add eslint_d
	-- luarocks install luacheck
	local prettier = null_ls.builtins.formatting.prettier
	prettier.filetypes = { "css", "scss", "html", "json", "yaml", "markdown" }

	local luacheck = null_ls.builtins.diagnostics.luacheck
	luacheck._opts.args = {
		"--globals",
		"vim",
		"mxvim",
		"packer_plugins",
		"packer_bootstrap",
		"--formatter",
		"plain",
		"--codes",
		"--ranges",
		"--filename",
		"$FILENAME",
		"-",
	}

	local sources = {
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.codespell,
		luacheck,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.stylua,
		prettier,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.code_actions.gitsigns,
	}
	null_ls.setup({ sources = sources, debug = true })
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