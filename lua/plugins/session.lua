return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
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
	{
		"stevearc/overseer.nvim",
		event = "VeryLazy",
		opts = {
			task_list = {
				direction = "bottom",
			},
		},
		keys = {
			{
				"<F6>",
				":OverseerToggle<cr>",
				mode = { "n", "i" },
				desc = "Overseer Toggle",
			},
			{
				"<leader>rr",
				":OverseerRun<cr>",
				mode = { "n" },
				desc = "OverseerRun",
			},
		},
	},
}