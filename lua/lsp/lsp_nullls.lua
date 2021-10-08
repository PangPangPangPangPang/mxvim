local M = {}
M.setup = function()
	vim.defer_fn(function()
		vim.cmd([[ PackerLoad null-ls.nvim]])
	end, 1000)
end
M.config = function()
	local lspconfig = require("lspconfig")
	local config = require("config._lsp_config").make_config()
	local null_ls = require("null-ls")
	-- pip3 install codespell
	-- yarn add global eslint_d
	-- luarocks install luacheck
	local prettier = null_ls.builtins.formatting.prettier
	prettier.filetypes = { "css", "scss", "html", "json", "yaml", "markdown" }

	local luacheck = null_ls.builtins.diagnostics.luacheck
	luacheck._opts.args = {
		"--globals",
        "vim mxvim packer_plugins",
		"--formatter",
		"plain",
		"--codes",
		"--ranges",
		"--filename",
		"$FILENAME",
		"-",
	}
    print(vim.inspect(luacheck))

	local sources = {
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.codespell,
		luacheck,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.stylua,
		prettier,
	}
	null_ls.config({ sources = sources, debug = true })
	lspconfig["null-ls"].setup(config)
end
return M
