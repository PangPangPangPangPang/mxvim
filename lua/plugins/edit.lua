return {
	-- commenter
	{
		"tpope/vim-commentary",
		config = function()
			vim.g.kommentary_create_default_mappings = false
			vim.api.nvim_set_keymap("n", "<leader>/", "gcc", {})
			vim.api.nvim_set_keymap("v", "<leader>/", "gc", {})
		end,
	},
	-- fold
	{
		"kevinhwang91/nvim-ufo",
		dependencies = 'kevinhwang91/promise-async',
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._other").ufo_config(0)
		end
	},
	-- input method
	{
		"ZSaberLv0/ZFVimIM",
		lazy = true,
		keys = {
			{ "<c-x>", "<cmd>lua toggle_zfvimim()<cr>",  mode = "n" },
			{ "<c-x>", "<c-o>:lua toggle_zfvimim()<cr>", mode = "i" },
		},
		dependencies = {
			"ZSaberLv0/ZFVimJob",
			"ZSaberLv0/ZFVimGitUtil",
			"PangPangPangPangPang/ZFVimIM_pinyin",
			"ZSaberLv0/ZFVimIM_openapi",
		},
		init = function()
			require("config._zfvimim").setup()
		end,
		config = function()
			require("config._zfvimim").config()
		end,
	},
	{
		"ybian/smartim",
		lazy = true,
		-- event = { "InsertEnter" },
		config = function()
			-- default IME mode
			vim.g.smartim_default = "com.apple.keylayout.ABC"
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("config._autopairs").setup()
		end,
	},
	{ "tpope/vim-surround" },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			continue = false,
			modes = {
				search = {
					enabled = false
				},
				char = {
					multi_line = true,
					jump_labels = true,
					keys = { "f", "F", "t", "T", ";", ","},
					highlight = { backdrop = false },
				}
			}
		},
		keys = {
			{
				"cl",
				mode = { "n", "x", "o" },
				function()
					require("config._flash").jump()
				end,
				desc = "Flash",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"justinmk/vim-sneak",
		enabled = false,
		lazy = true,
		config = function()
			require("config._sneak").config()
		end,
	},
	{
		"kshenoy/vim-signature",
		enabled = false,
		lazy = true,
	},
	{
		"simnalamburt/vim-mundo",
		cmd = { "MundoToggle" },
		keys = {
			{ "<F7>", "<cmd>MundoToggle<cr>", mode = "n" },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		ft = { "markdown" },
	},
	-- html
	{
		"mattn/emmet-vim",
		ft = { "css", "javascriptreact", "html", "typescriptreact" },
		init = function()
			vim.g.user_emmet_expandabbr_key = "<C-y><tab>"
			vim.g.user_emmet_prev_key = "<C-y>p"
		end,
	},

}