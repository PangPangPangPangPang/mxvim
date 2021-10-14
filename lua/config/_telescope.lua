local M = {}
M.map = function()
	local map = require("utils").map
	map("n", "<c-p>", ":Telescope find_files<cr>", { silent = true })
	map("n", "<leader>b", ":Telescope buffers<cr>", { silent = true })
	map("n", "<leader>f", ":Telescope live_grep<cr>", { silent = true })
	vim.cmd([[
        command! -nargs=0 LS :Telescope buffers
        cnoreabbrev ls LS
    ]])
end
M.config = function()
	local map = require("utils").map
	map(
		"n",
		"<leader>ca",
		":lua require'telescope.builtin'.lsp_code_actions(require('telescope.themes').get_cursor({}))<cr>",
		{ silent = true }
	)
	map(
		"n",
		"<c-]>",
		":lua require'telescope.builtin'.lsp_definitions(require('telescope.themes').get_dropdown({}))<cr>",
		{ silent = true }
	)
	map(
		"n",
		"gi",
		":lua require'telescope.builtin'.lsp_implementations(require('telescope.themes').get_dropdown({}))<cr>",
		{ silent = true }
	)
	map(
		"n",
		"gr",
		":lua require'telescope.builtin'.lsp_references(require('telescope.themes').dropdownrsor({}))<cr>",
		{ silent = true }
	)
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			mappings = {
				i = {
					-- To disable a keymap, put [map] = false
					-- So, to not map "<C-n>", just put
					["<c-x>"] = false,
					-- Otherwise, just set the mapping to the function that you want it to be.
					["<c-i>"] = actions.select_horizontal,

					-- You can perform as many actions in a row as you like
					["<esc>"] = actions.close,
					["<C-l>"] = actions.send_to_qflist + actions.open_qflist,
					["<c-c>"] = { "<esc>", type = "command" },
				},
				n = {
					["<esc>"] = actions.close,
					["<c-c>"] = false,
					["<c-l>"] = actions.send_to_qflist + actions.open_qflist,
				},
			},
			prompt_prefix = " ❤  ",
			selection_caret = " ▶ ",
			entry_prefix = "  ",
			initial_mode = "insert",
			-- selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "vertical",
			layout_config = {
				horizontal = {
					mirror = false,
					prompt_position = "top",
					width = 0.75,
					preview_cutoff = 120,
				},
				vertical = {
					mirror = true,
					width = 0.50,
					prompt_position = "top",
				},
			},
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = {},
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			path_display = { "absolute" },
			winblend = 0,
			border = {},
			borderchars = {
				"─",
				"│",
				"─",
				"│",
				"╭",
				"╮",
				"╯",
				"╰",
			},
			color_devicons = true,
			use_less = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

			-- Developer configurations: Not meant for general override
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = false, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
	require("telescope").load_extension("fzf")
end
return M
