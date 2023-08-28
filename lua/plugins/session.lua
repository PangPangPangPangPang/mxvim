return {
	{
		'goolord/alpha-nvim',
		enabled = vim.fn.exists("g:neovide") == 1,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			"Shatur/neovim-session-manager"
		},
		config = function()
			require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
		end
	},
	{
		"Shatur/neovim-session-manager",
		cmd = { "SessionManager" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>s", "<cmd>SessionManager load_session<cr>", mode = "n" },
		},
	},
}