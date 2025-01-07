return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			dashboard = {
				sections = {
					{
						section = "terminal",
						cmd = "pokemon-colorscripts -r --no-title; sleep .1",
						random = 10,
						pane = 1,
						height = 30,
						width = 40,
					},
					{
						icon = " ",
						key = "s",
						desc = "Open Session",
						action = "<cmd>SessionManager load_session<CR>",
						pane = 2,
						padding = 1,
					},
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.dashboard.pick('files')",
						pane = 2,
						padding = 1,
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
						pane = 2,
						padding = 1,
					},
					{
						icon = " ",
						key = "q",
						desc = "Quit",
						action = ":qa",
						pane = 2,
						padding = 1,
					},
					{ section = "startup", pane = 2 },
				},
			},
		},
	},
	{
		"Shatur/neovim-session-manager",
		cmd = { "SessionManager" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>s", "<cmd>SessionManager load_session<cr>", mode = "n", desc = "Load sessions" },
		},
	},
}