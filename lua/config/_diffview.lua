local M = {}
M.config = function()
	-- Lua
	local actions = require("diffview.actions")

	require("diffview").setup({
		diff_binaries = false, -- Show diffs for binaries
		enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
		git_cmd = { "git" }, -- The git executable followed by default args.
		use_icons = true,   -- Requires nvim-web-devicons
		icons = {           -- Only applies when use_icons is true.
			folder_closed = "",
			folder_open = "",
		},
		signs = {
			fold_closed = "",
			fold_open = "",
			done = "✓",
		},
		view = {
			-- Configure the layout and behavior of different types of views.
			-- Available layouts:
			--  'diff1_plain'
			--    |'diff2_horizontal'
			--    |'diff2_vertical'
			--    |'diff3_horizontal'
			--    |'diff3_vertical'
			--    |'diff3_mixed'
			--    |'diff4_mixed'
			-- For more info, see ':h diffview-config-view.x.layout'.
			default = {
				-- Config for changed files, and staged files in diff views.
				layout = "diff2_horizontal",
			},
			merge_tool = {
				-- Config for conflicted files in diff views during a merge or rebase.
				layout = "diff3_horizontal",
				disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
			},
			file_history = {
				-- Config for changed files in file history views.
				layout = "diff2_horizontal",
			},
		},
		file_panel = {
			listing_style = "tree",  -- One of 'list' or 'tree'
			tree_options = {         -- Only applies when listing_style is 'tree'
				flatten_dirs = true, -- Flatten dirs that only contain one single dir
				folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
			},
			win_config = {           -- See ':h diffview-config-win_config'
				position = "right",
				width = 35,
			},
		},
		file_history_panel = {
			win_config = { -- See ':h diffview-config-win_config'
				position = "bottom",
				height = 16,
			},
		},
		commit_log_panel = {
			win_config = {}, -- See ':h diffview-config-win_config'
		},
		default_args = { -- Default args prepended to the arg-list for the listed commands
			DiffviewOpen = {},
			DiffviewFileHistory = {},
		},
		hooks = {},          -- See ':h diffview-config-hooks'
		keymaps = {
			disable_defaults = false, -- Disable the default keymaps
			view = {
				-- The `view` bindings are active in the diff buffers, only when the current
				-- tabpage is a Diffview.
				["<tab>"]      = actions.select_next_entry, -- Open the diff for the next file
				["<s-tab>"]    = actions.select_prev_entry, -- Open the diff for the previous file
				["s"]          = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
				["gf"]         = actions.goto_file,     -- Open the file in a new split in the previous tabpage
				["<C-w><C-f>"] = actions.goto_file_split, -- Open the file in a new split
				["<C-w>gf"]    = actions.goto_file_tab, -- Open the file in a new tabpage
				["<cr>"]  = actions.focus_files,   -- Bring focus to the file panel
				["<leader>b"]  = actions.toggle_files,  -- Toggle the file panel.
				["g<C-x>"]     = actions.cycle_layout,  -- Cycle through available layouts.
				["[e"]         = actions.prev_conflict, -- In the merge_tool: jump to the previous conflict
				["]e"]         = actions.next_conflict, -- In the merge_tool: jump to the next conflict
				["<leader>do"] = actions.conflict_choose("ours"), -- Choose the OURS version of a conflict
				["<leader>dt"] = actions.conflict_choose("theirs"), -- Choose the THEIRS version of a conflict
				["<leader>db"] = actions.conflict_choose("base"), -- Choose the BASE version of a conflict
				["<leader>da"] = actions.conflict_choose("all"), -- Choose all the versions of a conflict
				["dx"]         = actions.conflict_choose("none"), -- Delete the conflict region
				["c"]          = function()
					vim.cmd('Neogit commit')
				end,
				["p"]          = function()
					vim.cmd('Neogit push')
				end,
				["P"]          = function()
					vim.cmd('Neogit pull')
				end,
				["q"]          = function()
					vim.cmd('tabc')
				end
			},
			diff1 = { --[[ Mappings in single window diff layouts ]] },
			diff2 = {

			},
			diff3 = {
				-- Mappings in 3-way diff layouts
				{ { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
				{ { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
			},
			diff4 = {
				-- Mappings in 4-way diff layouts
				{ { "n", "x" }, "1do", actions.diffget("base") }, -- Obtain the diff hunk from the BASE version of the file
				{ { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
				{ { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
			},
			file_panel = {
				["j"]      = actions.next_entry, -- Bring the cursor to the next file entry
				["<down>"] = actions.next_entry,
				["k"]      = actions.prev_entry, -- Bring the cursor to the previous file entry.
				["<up>"]   = actions.prev_entry,
				-- ["<cr>"]          = actions.select_entry, -- Open the diff for the selected entry.
				["o"]      = actions.select_entry,
				["<cr>"]   = actions.focus_entry,   -- Open the entry under the cursor in a diffview
				["a"]      = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
				["s"]      = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
				["S"]      = actions.stage_all,      -- Stage all entries.
				["U"]      = actions.unstage_all,    -- Unstage all entries.
				["X"]      = actions.restore_entry,  -- Restore entry to the state on the left side.
				["x"]      = actions.restore_entry,  -- Restore entry to the state on the left side.
				["R"]      = actions.refresh_files,  -- Update stats and entries in the file list.
				["L"]      = actions.open_commit_log, -- Open the commit log panel.
				["<c-u>"]  = actions.scroll_view(-0.25), -- Scroll the view up
				["<c-d>"]  = actions.scroll_view(0.25), -- Scroll the view down
				["i"]      = actions.listing_style,  -- Toggle between 'list' and 'tree' views
				["f"]      = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
				["c"]      = function()
					vim.cmd('Neogit commit')
				end,
				["p"]      = function()
					vim.cmd('Neogit push')
				end,
				["P"]      = function()
					vim.cmd('Neogit pull')
				end,
				["q"]      = function()
					vim.cmd('tabc')
				end
			},
			file_history_panel = {
				["g!"]            = actions.options, -- Open the option panel
				["<C-A-d>"]       = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
				["y"]             = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
				["L"]             = actions.open_commit_log,
				["zR"]            = actions.open_all_folds,
				["zM"]            = actions.close_all_folds,
				["j"]             = actions.next_entry,
				["<down>"]        = actions.next_entry,
				["k"]             = actions.prev_entry,
				["<up>"]          = actions.prev_entry,
				["<cr>"]          = actions.select_entry,
				["o"]             = actions.select_entry,
				["<2-LeftMouse>"] = actions.select_entry,
				["<c-b>"]         = actions.scroll_view(-0.25),
				["<c-f>"]         = actions.scroll_view(0.25),
				["q"]             = function()
					vim.cmd('tabc')
				end
			},
			option_panel = {
				["<tab>"] = actions.select_entry,
				["q"]     = actions.close,
			},
		},
	})
end

M.hl_diff = function(shade_colors)
	local shade_default_colors = require('theme').colors(0.7)
	vim.cmd(string.format("hi! DiffAdd guibg=%s guifg=none", shade_default_colors.green))
	vim.cmd(string.format("hi! DiffDelete guibg=%s guifg=%s", shade_default_colors.red, shade_default_colors.bg))
	vim.cmd(string.format("hi! DiffText guibg=%s guifg=none", shade_colors.green))
	vim.cmd(string.format("hi! DiffChange guibg=%s guifg=none", shade_default_colors.green))
end
return M