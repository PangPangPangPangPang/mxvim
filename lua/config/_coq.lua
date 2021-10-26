local M = {}
M.setup = function()
	if mxvim.use_coq == false then
		return
	end
	vim.g.coq_settings = {
		auto_start = true,
		keymap = { recommended = false, jump_to_mark = "<tab>" },
		display = { pum = { fast_close = false }, icons = { mode = 'none' } },
	}
	vim.defer_fn(function()
		vim.cmd([[
            PackerLoad coq_nvim
        ]])
	end, 200)
end
M.config = function()
	vim.api.nvim_exec(
		[[
    ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
    ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
    ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
    ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
    ]],
		false
	)
end

return M
