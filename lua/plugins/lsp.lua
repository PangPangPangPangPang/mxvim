return {
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			{ "williamboman/mason.nvim",  lazy = true },
			{ "nvim-lua/lsp-status.nvim", lazy = true },
			{
				"neovim/nvim-lspconfig",
				opts = {
					inlay_hints = { enabled = true },
				},
				config = function()
					require("config._lsp_config").config()
				end,
			},
		},
		config = function()
			require("config._mason").config()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"onsails/lspkind-nvim",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			{
				"hrsh7th/cmp-vsnip",
				dependencies = {
					"hrsh7th/vim-vsnip-integ",
					"hrsh7th/vim-vsnip",
					"rafamadriz/friendly-snippets",
				},
			},
			{
				"quangnguyen30192/cmp-nvim-tags",
				lazy = true,
				event = "VeryLazy",
			},
		},
		config = function()
			require("config._nvim_cmp").config()
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		lazy = true,
		enabled = mxvim.enable_lspsage,
		event = "VeryLazy",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		config = function()
			require("config._lsp_saga").config()
		end,
	},
	{
		"folke/lsp-trouble.nvim",
		lazy = true,
		cmd = { "LspTrouble", "Trouble" },
		config = function()
			require("config._lsp_trouble").config()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		enabled = false,
		-- cmd = { "SymbolsOutline" },
	},
	{
		'stevearc/aerial.nvim',
		keys = {
			{ "<F2>", "<cmd>AerialToggle<cr>", { "n", "i" } },
		},
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
	},
	require("lsp.lsp_ts"),
	{
		"jose-elias-alvarez/null-ls.nvim",
		enabled = false,
		-- lazy = true,
		dependencies = { "neovim/nvim-lspconfig" },
		setup = function()
			require("lsp.lsp_nullls").setup()
		end,
		config = function()
			require("lsp.lsp_nullls").config()
		end,
	},
}