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
M.ufo_config = function(opts)
	vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
	vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
	require("ufo").setup(opts)
end
M.ufo_opts = function()
	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = (" ◉ %d "):format(endLnum - lnum)
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
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end

	return {
		fold_virt_text_handler = handler,
		provider_selector = function()
			return { "indent" }
		end,
		open_fold_hl_timeout = 400,
		close_fold_kinds_for_ft = { "imports", "comment" },
		preview = {
			win_config = { border = { "", "─", "", "", "", "─", "", "" }, winblend = 0 },
			mappings = {
				scrollU = "<C-b>",
				scrollD = "<C-f>",
				jumpTop = "[",
				jumpBot = "]",
			},
		},
	}
end

return M