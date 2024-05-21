return {
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = mxvim.enable_treesitter,
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/playground",
			"HiPhish/rainbow-delimiters.nvim",
			"nvim-treesitter/nvim-treesitter-textobjects",
			{
				"windwp/nvim-ts-autotag",
				config = function()
					require('nvim-ts-autotag').setup({
						opts = {
							-- Defaults
							enable_close = true, -- Auto close tags
							enable_rename = true, -- Auto rename pairs of tags
							enable_close_on_slash = true -- Auto close on trailing </
						}
					})
				end,
			},
			"lukas-reineke/indent-blankline.nvim",
			"numToStr/Comment.nvim",
			-- "m-demare/hlargs.nvim",
		},
		build = ":TSUpdate",
		config = function()
			require("config._treesitter")
		end,
	},
}