return {
	{ "nvim-lua/popup.nvim", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "drmikehenry/vim-fixkey", event = "VeryLazy" },
	-- Readline style insertion
	{ "tpope/vim-rsi", event = "InsertEnter" },
	{
		"nmac427/guess-indent.nvim",
		event = "VeryLazy",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	{ "kevinhwang91/nvim-bqf", ft = "qf", branch = "main" },
}
