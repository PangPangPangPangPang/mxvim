return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		keys = {
			{ "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", mode = { "n", "v" }, desc = "Stage hunk" },
			{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", mode = { "n", "v" }, desc = "Unstage hunk" },
			{ "<leader>gx", "<cmd>Gitsigns reset_hunk<cr>", mode = { "n", "v" }, desc = "Reset hunk" },
			{ "<leader>gb", "<cmd>Gitsigns blame_line<cr>", mode = { "n", "v" }, desc = "Blame line" },
		},
		event = "VeryLazy",
		config = function()
			require("config._gitsigns").config()
		end,
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"NeogitOrg/neogit",
		},
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
		cmd = { "Git" },
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua",     -- optional
		},
		-- keys = {
		-- 	{ "<F3>", '<cmd>Neogit<cr>', mode = "n" },
		-- },
		setup = {
			vim.cmd([[ com! G lua require("neogit").open({ kind = "vsplit" })]])
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				integrations = {
					diffview = true
				},
				signs = {
					-- { CLOSED, OPENED }
					hunk = { "", "" },
					item = { "", "" },
					section = { "󰨙 ", "󰨚 " },
				},
				mappings = {
					status = {
						["o"] = "Toggle",
						["a"] = "Stage",
						["="] = "Toggle",
						["P"] = "PullPopup",
						["p"] = "PushPopup",
					}
				}
			})
		end
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		-- optional for floating window border decoration
		cmd = { "LazyGit" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}