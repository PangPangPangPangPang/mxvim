return {
	{
		"voldikss/vim-floaterm",
		cmd = { "FloatermToggle", "FloatermNew" },
		keys = {
			{ "<F5>",       "<cmd>lua require('config._vim_floaterm').open_term()<cr>",        mode = "n" },
			{ "<F5>",       "<C-\\><C-n>:lua require('config._vim_floaterm').open_term()<CR>", mode = "t" },
			{ "<Esc>",      "<C-\\><C-n>:lua require('config._vim_floaterm').close()<CR>",     mode = "t" },
			{ "<leader>lg", ":lua require('config._vim_floaterm').open_lazygit()<CR>",         mode = "n" },
		},
		config = function()
			require("config._vim_floaterm").map()
		end,
	},
	{
		"karb94/neoscroll.nvim",
		enabled = not vim.g.neovide,
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._neoscroll").config()
		end,
	},
	{
		"szw/vim-maximizer",
		cmd = { "MaximizerToggle" },
		init = function()
			local lmap = require("utils").map
			lmap("n", "<c-w>z", ":MaximizerToggle<CR>", { silent = true })
			lmap("v", "<c-w>z", ":MaximizerToggle<CR>gv", { silent = true })
		end,
	},
	{ "tpope/vim-dadbod", cmd = { "DB" } },
	{
		"skywind3000/vim-quickui",
		lazy = true,
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
}