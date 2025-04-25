return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		keys = {
			{
				"<leader>s",
				function()
					require("persistence").select()
				end,
				mode = "n",
				desc = "Load sessions",
			},
		},
	},
}