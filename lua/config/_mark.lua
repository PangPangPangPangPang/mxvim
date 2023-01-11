local M = {}
M.config = function()
	require("marks").setup({
		-- whether to map keybinds or not. default true
		default_mappings = true,
		-- which builtin marks to show. default {}
		-- builtin_marks = { ".", "<", ">", "^" },
		-- whether movements cycle back to the beginning/end of buffer. default true
		cyclic = true,
		-- whether the shada file is updated after modifying uppercase marks. default false
		force_write_shada = false,
		-- how often (in ms) to redraw signs/recompute mark positions.
		-- higher values will have better performance but may cause visual lag,
		-- while lower values may cause performance penalties. default 150.
		refresh_interval = 250,
		-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
		-- marks, and bookmarks.
		-- can be either a table with all/none of the keys, or a single number, in which case
		-- the priority applies to all marks.
		-- default 10.
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		-- disables mark tracking for specific filetypes. default {}
		excluded_filetypes = {},
		-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
		-- sign/virttext. Bookmarks can be used to group together positions and quickly move
		-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
		-- default virt_text is "".
		bookmark_0 = {
			sign = "⚑",
			virt_text = "   0",
		},
		bookmark_1 = {
			sign = "⚑",
			virt_text = "   1",
		},
		bookmark_2 = {
			sign = "⚑",
			virt_text = "   2",
		},
		bookmark_3 = {
			sign = "⚑",
			virt_text = "   3",
		},
		bookmark_4 = {
			sign = "⚑",
			virt_text = "   4",
		},
		bookmark_5 = {
			sign = "⚑",
			virt_text = "   5",
		},
		bookmark_6 = {
			sign = "⚑",
			virt_text = "   6",
		},
		bookmark_7 = {
			sign = "⚑",
			virt_text = "   7",
		},
		bookmark_8 = {
			sign = "⚑",
			virt_text = "   8",
		},
		bookmark_9 = {
			sign = "⚑",
			virt_text = "   9",
		},
		mappings = {},
	})
end
return M
