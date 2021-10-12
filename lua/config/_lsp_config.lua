local M = {}
local colors = require("theme").shade_colors(0.6)

M.setup = function()
	vim.defer_fn(function()
		vim.cmd([[
        PackerLoad nvim-lspinstall
        PackerLoad lsp_signature.nvim
        PackerLoad nvim-lspconfig
        ]])
		M.custom_handlers()
	end, 500)
end
M.config = function()
	local lspinstall = require("lspinstall")
	local lspconfig = require("lspconfig")

	local function setup_servers()
		lspinstall.setup()
		-- get all installed servers
		local servers = require("lspinstall").installed_servers()
		-- ... and add manually installed servers
		for _, server in pairs(servers) do
			local config
			-- language specific config
			if server == "efm" then
				config = require("lsp.lsp_efm").config(M.on_attach)
			else
				config = M.make_config()
				if server == "lua" then
					config.settings = require("lsp.lsp_lua").config()
				elseif server == "typescript" then
					config.on_attach = require("lsp.lsp_ts").on_attach
				end
			end
			lspconfig[server].setup(config)
		end
	end
	setup_servers()
	lspinstall.post_install_hook = function()
		setup_servers() -- reload installed servers
		vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
	end
end
M.set_signature = function(bufnr)
	require("lsp_signature").on_attach({}, bufnr)
end

M.set_keymap = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings.
	-- lsp
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- buf_set_keymap('n', '<c-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	-- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	-- buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	-- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>cq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	-- replace saga
	-- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
	-- opts)
	-- buf_set_keymap("n", "<space>cd", "<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "g[", "<cmd>lua vim.diagnostic.goto_prev({enable_popup=false})<CR>", opts)
	buf_set_keymap("n", "g]", "<cmd>lua vim.diagnostic.goto_next({enable_popup=false})<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- buf_set_keymap('n', '<space>cn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>cp", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
	end
	if client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("v", "<space>cp", ":'<,'>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
	-- buf_set_keymap('n', '<space>cp', ':Neoformat<CR>', opts)

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		local show_diag =
			"autocmd CursorHold <buffer> lua vim.diagnostic.show_position_diagnostics({focusable=false,border='rounded'})"
		if packer_plugins["lspsaga.nvim"] and packer_plugins["lspsaga.nvim"].loaded then
			show_diag = "autocmd CursorHold * lua require'lspsaga.diagnostic'.show_cursor_diagnostics()"
		end
		vim.cmd(string.format(
			[[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        %s
        " autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 1000)
        augroup END

        hi! default link DiagnosticVirtualTextError Comment
        hi! default link DiagnosticVirtualTextHint Comment
        hi! default link DiagnosticVirtualTextInfo Comment
        hi! default link DiagnosticVirtualTextWarn Comment

        hi! DiagnosticDefaultInfo guifg=%s
        hi! DiagnosticUnderlineError gui=undercurl term=undercurl guisp=%s guifg=none
        hi! DiagnosticUnderlineHint gui=undercurl term=undercurl guisp=%s guifg=none
        hi! DiagnosticUnderlineWarn gui=undercurl term=undercurl guisp=%s guifg=none
        hi! DiagnosticUnderlineInfo gui=undercurl term=undercurl guisp=%s guifg=none
        hi! DiagnosticSignError gui=none guifg=%s
        hi! DiagnosticSignHint gui=none guifg=%s
        hi! DiagnosticSignWarn gui=none guifg=%s
        hi! DiagnosticSignInfo gui=none guifg=%s
        highlight! link LspReference %s
        highlight! link LspReferenceText LspReference
        highlight! link LspReferenceRead LspReference
        highlight! link LspReferenceWrite LspReference
        ]],
			show_diag,
			colors.bg,
			colors.red,
			colors.blue,
			colors.yellow,
			colors.blue,
			colors.red,
			colors.blue,
			colors.yellow,
			colors.blue,
			colors.highlight ~= nil and colors.highlight or "Visual"
		))
	end
end

M.on_attach = function(client, bufnr)
	M.set_signature(bufnr)
	M.set_keymap(client, bufnr)
end

M.make_config = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- capabilities.textDocument.completion.completionItem.snippetSupport = true
	-- capabilities.textDocument.completion.completionItem.resolveSupport = {
	--     properties = {'documentation', 'detail', 'additionalTextEdits'}
	-- }
	if mxvim.use_cmp == true then
		capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
	end
	local config = {
		root_dir = require("lspconfig/util").root_pattern("package.json", ".eslintrc", ".git"),
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = M.on_attach,
	}
	if mxvim.use_cmp == true then
		return config
	else
		local coq = require("coq")
		return coq.lsp_ensure_capabilities(config)
	end
end

M.signature = function()
	local safe_require = require("utils").safe_require
	safe_require("lsp_signature", function(lspsignature)
		local cfg = {
			debug = false, -- set to true to enable debug logging
			log_path = "debug_log_file_path", -- debug log path
			verbose = false, -- show debug line number

			bind = true, -- This is mandatory, otherwise border config won't get registered.
			-- If you want to hook lspsaga or other signature handler, pls set to false
			doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
			-- set to 0 if you DO NOT want any API comments be shown
			-- This setting only take effect in insert mode, it does not affect signature help in normal
			-- mode, 10 by default

			floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

			floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
			-- will set to true when fully tested, set to false will use whichever side has more space
			-- this setting will be helpful if you do not want the PUM and floating win overlap
			fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
			hint_enable = true, -- virtual hint enable
			hint_prefix = " ", -- Panda for parameter
			hint_scheme = "String",
			use_lspsaga = false, -- set to true if you want to use lspsaga popup
			hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
			max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
			-- to view the hiding contents
			max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
			transpancy = 20, -- set this value if you want the floating windows to be transpant (100 fully transpant), nil to disable(default)
			handler_opts = {
				border = "single",   -- double, single, shadow, none
			},

			always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

			auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
			extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
			zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

			padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

			shadow_blend = 36, -- if you using shadow as border use this set the opacity
			shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
			timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
			toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
		}
		lspsignature.setup(cfg)
	end)
end

M.custom_handlers = function()
	-- local signs = {
	-- 	Error = " ",
	-- 	Warn = " ",
	-- 	Hint = " ",
	-- 	Info = " ",
	-- }
	local signs = { Hint = " ", Info = " ", Warn = " ", Error = " " }

	local border = {
		{ "╭", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╮", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "╯", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╰", "FloatBorder" },
		{ "│", "FloatBorder" },
	}

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
	local lsp = vim.lsp
	lsp.handlers["textDocument/hover"] = vim.lsp.with(lsp.handlers.hover, { border = border })
	lsp.handlers["textDocument/signatureHelp"] = lsp.with(vim.lsp.handlers.signature_help, { border = border })
	lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = {
			spacing = 2,
		},
		signs = function()
			return true
		end,
		underline = true,
		update_in_insert = false,
	})
end

return M
