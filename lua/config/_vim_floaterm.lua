local M = {}
M.default_open_status = false
M.lazygit_open_status = false
M.open_term = function()
	M.default_open_status = not M.default_open_status
	vim.cmd([[ exe "FloatermToggle default" ]])
end
M.open_lazygit = function()
	M.lazygit_open_status = true
	vim.cmd([[ exe "FloatermNew --width=0.8 --height=0.8 lazygit" ]])
end

M.close = function()
	if M.default_open_status == true then
		M.default_open_status = false
		vim.cmd([[ exe "FloatermToggle default" ]])
	elseif M.lazygit_open_status == true then
		vim.cmd([[ exe "FloatermKill" ]])
		M.lazygit_open_status = false
	end
end
M.map = function()
	local g = vim.g
	local map = require("utils").map
	vim.api.nvim_command("hi! link FloatermBorder Directory")
	g.floaterm_title = "$1/$2"
	map("n", "<F5>", ":lua require('config._vim_floaterm').open_term()<CR>", { silent = true })
	map("t", "<F5>", "<C-\\><C-n>:lua require('config._vim_floaterm').open_term()<CR>", { silent = true })
	map("t", "<Esc>", "<C-\\><C-n>:lua require('config._vim_floaterm').close()<CR>", { silent = true })
	map("n", "<leader>lg", ":lua require('config._vim_floaterm').open_lazygit()<CR>", { silent = true })
	vim.cmd([[ autocmd FileType floaterm lua require('config._vim_floaterm').normal_map()]])
end

M.normal_map = function()
	vim.api.nvim_buf_set_keymap(
		0,
		"n",
		"<Esc>",
		"<C-\\><C-n>:lua require('config._vim_floaterm').close()<CR>",
		{ silent = true }
	)
end

return M
