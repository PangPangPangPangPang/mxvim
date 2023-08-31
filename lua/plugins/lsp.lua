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
		"j-hui/fidget.nvim",
		enabled = false,
		-- lazy = true,
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"https://gitlab.com/yorickpeterse/nvim-dd.git",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("dd").setup({
				timeout = 0,
			})
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
				-- if you want the sources is available for some file types
				-- ft = {
				--     "javascriptreact",
				--     "typescriptreact",
				--     "javascript",
				--     "typescript",
				--     "lua",
				-- },
			},
		},
		config = function()
			require("config._nvim_cmp").config()
		end,
	},
	{
		"ms-jpq/coq_nvim",
		enabled = false,
		-- lazy = true,
		branch = "coq",
		dependencies = {
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		},
		config = function()
			require("config._coq").config()
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