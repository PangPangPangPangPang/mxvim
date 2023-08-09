local M = {}
M.setup_hop = function()
	vim.defer_fn(function()
		vim.cmd([[ PackerLoad hop.nvim ]])
		local map = require("utils").dmap
		map({ 'n', 'x' }, 'cl', ':HopWord<cr>')
	end, 400)
end
M.copilot_setup = function()
	vim.defer_fn(function()
		vim.cmd([[
        inoremap <silent><expr> <C-j> copilot#Accept("")
        let g:copilot_no_tab_map = 1
        PackerLoad copilot.vim ]])
	end, 200)
end
M.ufo_config = function()
	vim.o.foldcolumn = '0' -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
	vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
	vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
	-- Option 2: nvim lsp as LSP client
	-- Tell the server the capability of foldingRange,
	-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true
	}
	local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
	for _, ls in ipairs(language_servers) do
		require('lspconfig')[ls].setup({
			capabilities = capabilities
			-- you can add other fields for setting up lsp server in this table
		})
	end
	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = ('  %d '):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, 'MoreMsg' })
		return newVirtText
	end
	require('ufo').setup({
		fold_virt_text_handler = handler
	})
end
return M