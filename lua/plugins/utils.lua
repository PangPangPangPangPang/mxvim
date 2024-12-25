return {
	{
		"voldikss/vim-floaterm",
		cmd = { "FloatermToggle", "FloatermNew" },
		keys = {
			{ "<F5>",       "<cmd>lua require('config._vim_floaterm').open_term()<cr>",               mode = "n" },
			{ "<F5>",       "<C-\\><C-n>:lua require('config._vim_floaterm').open_term()<CR>",        mode = "t" },
			{ "<F6>",       "<cmd>lua require('config._vim_floaterm').open_bottom_term()<cr>",        mode = "n" },
			{ "<F6>",       "<C-\\><C-n>:lua require('config._vim_floaterm').open_bottom_term()<CR>", mode = "t" },
			{ "<Esc>",      "<C-\\><C-n>:lua require('config._vim_floaterm').close()<CR>",            mode = "t" },
			{ "<leader>lg", ":lua require('config._vim_floaterm').open_lazygit()<CR>",                mode = "n" },
		},
		config = function()
			require("config._vim_floaterm").map()
		end,
	},
	{
		"karb94/neoscroll.nvim",
		enabled = not vim.g.neovide,
		event = "VeryLazy",
		config = function()
			require("config._neoscroll").config()
		end,
	},
	{
		"0x00-ketsu/maximizer.nvim",
		keys = {
			{ "<c-w>z", "<cmd>lua require('maximizer').toggle()<CR>", mode = "n" },
		},
		config = function()
			require("maximizer").setup({})
		end,
	},
	{ "tpope/vim-dadbod", cmd = { "DB" } },
	{
		"skywind3000/vim-quickui",
		event = "VeryLazy",
		init = function()
			vim.g.quickui_border_style = 2
			vim.g.quickui_color_scheme = "system"
		end,
	},
	{
		-- "~/bilibili_live_broadcast",
		"PangPangPangPangPang/bilibili_live_broadcast",
		enabled = false,
		lazy = true,
		cmd = { "BiliLive" },
		config = function()
			require("config._bili_live").config()
		end,
		dependencies = { "rcarriga/nvim-notify" },
	},
	{
		"jackMort/ChatGPT.nvim",
		lazy = true,
		cmd = { "ChatGPT" },
		config = function()
			require("chatgpt").setup({
				keymaps = {
					close = { "<C-c>" },
					submit = "<C-e>",
					yank_last = "<C-y>",
					yank_last_code = "<C-k>",
					scroll_up = "<C-u>",
					scroll_down = "<C-d>",
					toggle_settings = "<C-o>",
					new_session = "<C-n>",
					cycle_windows = "<Tab>",
					-- in the Sessions pane
					select_session = "<Space>",
					rename_session = "r",
					delete_session = "d",
				},

				-- optional configuration
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = { preset = "helix" },
		config = function()
			local wk = require("which-key")
			wk.setup({
				icons = {
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "➜", -- symbol used between a key and it's label
					group = "+", -- symbol prepended to a group
				},
				win = {
					width = 0.5,
					border = "single", -- none, single, double, shadow
					padding = { 1, 2 },
					zindex = 1000,     -- positive value to position WhichKey above other floating windows.
					wo = {
						winblend = 100,
					},
				},
				layout = {
					align = "right",
				},
				show_help = false, -- show a help message in the command line for using WhichKey
				show_keys = false, -- show the currently pressed key and its label as a message in the command line
			})
			wk.add({
				{ "<leader>g",  group = "Git" },
				{ "<leader>gA", desc = "Diff Choose all" },
				{ "<leader>gB", desc = "Diff Choose base" },
				{ "<leader>gX", desc = "Diff Choose none" },
				{ "<leader>go", desc = "Diff Choose ours" },
				{ "<leader>gt", desc = "Diff Choose theirs" },
			})
			wk.add({
				{ "<leader>w",  group = "Workspace" },
				{ "<leader>wa", desc = "Add workspace folder" },
			})
			wk.add({
				{ "<leader>l", group = "Diagnostic" },
			})
			wk.add({
				{ "<leader>=", group = "Format" },
			})
			wk.add({
				{ "<leader>c",  group = "Language Server" },
				{ "<leader>ca", desc = "Code action" },
			})
			wk.add({
				{ "<leader><Down>", group = "Change" },
				{ "<leader><Up>",   group = "Change" },
			})
		end,
	},
	{
		"github/copilot.vim",
		enabled = false,
		config = function()
			vim.cmd([[
		imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
		let g:copilot_no_tab_map = v:true
			]])
		end,
	},
	{
		"p5quared/apple-music.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = true,
		keys = {
			{
				"<leader>mm",
				function()
					require("apple-music").toggle_play()
				end,
				desc = "Toggle playback[M]",
			},
			{
				"<leader>ms",
				function()
					require("apple-music").toggle_shuffle()
				end,
				desc = "Toggle [S]huffle",
			},
			{
				"<leader>mp",
				function()
					require("apple-music").select_playlist_telescope()
				end,
				desc = "Find [P]laylists",
			},
			{
				"<leader>ma",
				function()
					require("apple-music").select_album_telescope()
				end,
				desc = "Find [A]lbum",
			},
			{
				"<leader>ms",
				function()
					require("apple-music").select_track_telescope()
				end,
				desc = "Find [S]ong",
			},
			{
				"<leader>mx",
				function()
					require("apple-music").cleanup_all()
				end,
				desc = "Cleanup Temp Playlists",
			},
		},
		{
			"nvzone/timerly",
			cmd = "TimerlyToggle",
			dependencies = {
				"nvzone/volt",
			},
		},
		{
			"nvzone/menu",
			-- lazy = true,
			config = function()
				-- Keyboard users
				vim.keymap.set("n", "<C-t>", function()
					require("menu").open("default")
				end, {})

				-- mouse users + nvimtree users!
				vim.keymap.set("n", "<Tab>", function()
					vim.cmd.exec('"normal! \\<RightMouse>"')

					local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
					require("menu").open(options, { mouse = true })
				end, {})
			end,
		},
	},
}