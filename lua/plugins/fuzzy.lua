return {
	{
		"mhinz/vim-grepper",
		event = "VeryLazy",
		init = function()
			require("config._grep").setup()
		end,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<c-p>", "<cmd>lua require('fzf-lua').files()<cr>" },
		},
		config = function()
			require("config._fzf").config()
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build =
				"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
			},
			"nvim-telescope/telescope-ui-select.nvim",
			"debugloop/telescope-undo.nvim",

		},
		keys = {
			-- { "<c-p>",     "<cmd>Telescope find_files<cr>" },
			{ "<leader>f", "<cmd>Telescope live_grep<cr>", mode = { "n" }, desc ="Live grep" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", mode = { "n" }, desc = "Open buffers" },
			{ "<F7>", "<cmd>Telescope undo<cr>", { "n", "i" } },
		},
		config = function()
			require("config._telescope").config()
		end,
	},

}