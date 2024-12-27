local M = {}
M.setup = function()
	local lsp_config = require("config._lsp_config")
	local config = lsp_config.make_config()
	config.init_options = {
		preferences = {
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
			importModuleSpecifierPreference = "non-relative",
		},
	}
	require("lspconfig").ts_ls.setup(config)
	-- vim.api.nvim_set_hl(0, "@lsp.mod.readonly.typescriptreact", { link = "@lsp" })
end
M.setup_vtsls = function()
	-- require("lspconfig.configs").vtsls = require("vtsls").lspconfig
	require("lspconfig").vtsls.setup({
		-- customize handlers for commands
		settings = {
			typescript = {
				inlayHints = {
					parameterNames = { enabled = "literals" },
					parameterTypes = { enabled = true },
					variableTypes = { enabled = true },
					propertyDeclarationTypes = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					enumMemberValues = { enabled = true },
				},
			},
		},
		handlers = {
			source_definition = function(err, locations) end,
			file_references = function(err, locations) end,
			code_action = function(err, actions) end,
		},
		-- automatically trigger renaming of extracted symbol
		refactor_auto_rename = true,
		refactor_move_to_file = {
			-- If dressing.nvim is installed, telescope will be used for selection prompt. Use this to customize
			-- the opts for telescope picker.
			telescope_opts = function(items, default) end,
		},
	})
end
M.ts_tools = {
	{
		"dmmulroy/ts-error-translator.nvim",
		event = "LspAttach",
		config = function()
			require("ts-error-translator").setup({
				auto_override_publish_diagnostics = true,
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		enabled = mxvim.enable_ts_tools,
		event = {
			"BufRead *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx",
			"BufNewFile *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = true
				client.server_capabilities.documentRangeFormattingProvider = true
				vim.keymap.set(
					"n",
					"<leader>cs",
					"<Cmd>TSToolsOrganizeImports<CR>",
					{ buffer = bufnr, desc = "Organize imports" }
				)
				-- vim.api.nvim_set_hl(0, "@lsp.mod.readonly.typescriptreact", { link = "@lsp" })
			end,
			handlers = {
				["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
					require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
					vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
				end,
			},
			settings = {
				publish_diagnostic_on = "change",
				-- expose_as_code_action = "all",
				tsserver_file_preferences = {
					includeCompletionsForModuleExports = true,
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
					quotePreference = "auto",
				},
			},
		},
	},
}
return M