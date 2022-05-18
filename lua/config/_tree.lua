local M = {}
local g = vim.g
M.setup = function()
	vim.defer_fn(function()
		vim.cmd([[
            PackerLoad nvim-tree.lua
        ]])
		local map = require("utils").dmap
		map({ "n", "i" }, "<F1>", ":NvimTreeToggle<CR>")
		map({ "n" }, "<leader>j", ":NvimTreeFindFile<CR>")
	end, 0)
end
M.config = function()
	local safe_require = require("utils").safe_require
	safe_require("nvim-tree.config", function(config)
		local tree_cb = config.nvim_tree_callback
		local function generate_cb_string(callback_name)
			return string.format("lua require'nvim-tree'.on_keypress('%s')", callback_name)
		end

		---@diagnostic disable-next-line: lowercase-global
		function open_luatree()
			local content = {
				{ "Copy File             &c", generate_cb_string("copy") },
				{ "Paste file            &p", generate_cb_string("paste") },
				{ "Rename file           &r", generate_cb_string("rename") },
				{ "Move file             &m", generate_cb_string("cut") },
				{ "Delete file           &d", generate_cb_string("remove") },
				{ "New Files             &n", generate_cb_string("create") },
				{ "Yank Path             &y", generate_cb_string("copy_path") },
				{ "Toggle ignored files  &.", generate_cb_string("toggle_dotfiles") },
				{ "Go back               &u", generate_cb_string("dir_up") },
				{ "Go Root               &R", "cd getcwd()" },
				{ "System Open           &s", generate_cb_string("system_open") },
			}
			local opts = { title = "menu", ignore_case = 0 }
			vim.call("quickui#context#open", content, opts)
		end

		g.nvim_tree_git_hl = 1

		require("nvim-tree").setup({
			disable_netrw = true,
			hijack_netrw = true,
			open_on_setup = true,
			ignore_ft_on_setup = {},
			-- auto_close = false,
			open_on_tab = true,
			hijack_cursor = true,
			update_cwd = true,
			diagnostics = {
				enable = false,
			},
			renderer = {
                indent_markers = {
                    enable = false,
                },
			},
			update_focused_file = {
				enable = false,
				update_cwd = false,
				ignore_list = { "node_modules", ".git", "build" },
			},
			system_open = {
				cmd = nil,
				args = {},
			},
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
				},
				open_file = {
					quit_on_open = false,
					resize_window = true,
					window_picker = {
						enable = false,
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
			},
			view = {
				height = 30,
                hide_root_folder = true,
				side = "left",
				preserve_window_proportions = false,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
				width = "15%",
				mappings = {
					custom_only = false,
					list = {
						{ key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
						{ key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
						{ key = "v", cb = tree_cb("vsplit") },
						{ key = "s", cb = tree_cb("split") },
						{ key = "<C-t>", cb = tree_cb("tabnew") },
						{ key = "<", cb = tree_cb("prev_sibling") },
						{ key = ">", cb = tree_cb("next_sibling") },
						{ key = "P", cb = tree_cb("parent_node") },
						{ key = "<BS>", cb = tree_cb("close_node") },
						{ key = "<S-CR>", cb = tree_cb("close_node") },
						{ key = "p", cb = tree_cb("preview") },
						{ key = "<Tab>", cb = ":lua open_luatree()<cr>" },
						{ key = "K", cb = tree_cb("first_sibling") },
						{ key = "J", cb = tree_cb("last_sibling") },
						{ key = ".", cb = tree_cb("toggle_dotfiles") },
						{ key = "R", cb = tree_cb("refresh") },
						{ key = "a", cb = tree_cb("create") },
						{ key = "d", cb = tree_cb("remove") },
						{ key = "r", cb = tree_cb("rename") },
						{ key = "<C-r>", cb = tree_cb("full_rename") },
						{ key = "x", cb = tree_cb("cut") },
						{ key = "c", cb = tree_cb("copy") },
						{ key = "p", cb = tree_cb("paste") },
						{ key = "y", cb = tree_cb("copy_name") },
						{ key = "Y", cb = tree_cb("copy_path") },
						{ key = "gy", cb = tree_cb("copy_absolute_path") },
						{ key = "[c", cb = tree_cb("prev_git_item") },
						{ key = "]c", cb = tree_cb("next_git_item") },
						{ key = "u", cb = tree_cb("dir_up") },
						{ key = "q", cb = tree_cb("close") },
						{ key = "g?", cb = tree_cb("toggle_help") },
					},
				},
			},
		})
	end)
end

M.theme = function()
	local colors = require("theme").theme_colors()
	local root_name = string.format("hi! NvimTreeRootFolder guifg=%s gui=bold", colors.yellow)
	local folder_name = string.format("hi! NvimTreeFolderName guifg=%s gui=bold", colors.blue)
	local opened_folder_name = string.format("hi! NvimTreeOpenedFolderName guifg=%s gui=bold", colors.blue)
	local empty_folder_foldername = string.format("hi! NvimTreeEmptyFolderName guifg=%s gui=bold", colors.blue)
	vim.cmd(string.format(
		[[
        augroup NvimTree
            %s
            %s
            %s
            %s
        augroup End
    ]],
		root_name,
		folder_name,
		opened_folder_name,
		empty_folder_foldername
	))
end

return M
