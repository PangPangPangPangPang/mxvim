return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._gitsigns").config()
		end,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose" },
		keys = {
			{ "<F3>", '<cmd>lua require("utils").toggleDiffView()<cr>', mode = "n" },
		},
		config = function()
			require("config._diffview").config()
		end,
	},

	{
		"tpope/vim-fugitive",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"rhysd/git-messenger.vim",
		cmd = { "GitMessenger" },
	},

}