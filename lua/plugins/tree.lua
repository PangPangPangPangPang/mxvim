return {
	{
		"kyazdani42/nvim-tree.lua",
		enabled = not mxvim.enable_neotree,
		lazy = true,
		cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
		init = function()
			require("config._tree").init()
		end,
		keys = {
			{ "<F1>",      "<cmd>NvimTreeToggle<cr>",   mode = "n", desc = "Jump to file tree" },
			{ "<leader>j", "<cmd>NvimTreeFindFile<cr>", mode = { "n" }, desc = "Jump to file tree" },
		},
		config = function()
			require("config._tree").config()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = mxvim.enable_neotree,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = { "Neotree" },
		keys = {
			{ "<F1>",      "<cmd>Neotree filesystem left toggle<cr>", mode = "n" },
			{ "<leader>j", "<cmd>Neotree reveal left<cr>",            mode = { "n" } },
		},
		config = function()
			require("config._neotree").config()
		end,
	},

}