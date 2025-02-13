return {
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "drmikehenry/vim-fixkey" },
	-- Readline style insertion
	{ "tpope/vim-rsi" },
	{
		"nmac427/guess-indent.nvim",
		event = "VeryLazy",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	{ "kevinhwang91/nvim-bqf", ft = "qf", branch = "main" },
}