local dmap = require("utils").dmap

------------------------------
-- => Status line
------------------------------
-- Always show the status line
dmap({ "n" }, "<leader>==", "mzG=gg`z", "Format all")
-- Copy to system clipboard
dmap({ "v" }, "Y", '"+y')

dmap({ "v", "n" }, "<c-h>", "<c-w>h")
dmap({ "v", "n" }, "<c-j>", "<c-w>j")
dmap({ "v", "n" }, "<c-k>", "<c-w>k")
dmap({ "v", "n" }, "<c-l>", "<c-w>l")

local squirrel = vim.fn.executable("/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel")
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		if squirrel then
			vim.fn.system([[
			/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --ascii_mode_prev
			]])
		end
	end
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		if squirrel then
			vim.fn.system([[
			/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --ascii_mode
			]])
		end
	end
})

dmap({ "n", "v" }, "<leader>q", ':lua require("utils").close_common()<cr>', "Close ignore buffer")