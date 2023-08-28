return {
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = mxvim.enable_treesitter,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/playground",
			"HiPhish/nvim-ts-rainbow2",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
			"m-demare/hlargs.nvim",
		},
		build = ":TSUpdate",
		config = function()
			require("config._treesitter")
			require("config._treesitter").inithlargs()
		end,
	},
}