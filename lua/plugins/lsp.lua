return {
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "nvim-lua/lsp-status.nvim" },
			{ "hrsh7th/nvim-cmp" },
			{ "neovim/nvim-lspconfig" },
		},
		config = function()
			require("config._mason").config()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		opts = {
			inlay_hints = { enabled = true },
		},
		config = function()
			require("config._lsp_config").config()
		end,
	},
	-- defer all NeoVim diagnostics for a less distracting coding experience
	{
		"https://gitlab.com/yorickpeterse/nvim-dd.git",
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
			},
		},
		config = function()
			require("config._nvim_cmp").config()
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		enabled = mxvim.enable_lspsaga,
		event = "LspAttach",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		config = function()
			require("config._lsp_saga").config()
		end,
	},
	{
		"folke/trouble.nvim",
		enabled = mxvim.enable_trouble,
		lazy = true,
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
			{
				"<c-]>",
				"<cmd>Trouble lsp_definitions focus=true<cr>",
				desc = "Definition",
			},
			{
				"<leader>cr",
				"<cmd>Trouble lsp_references focus=true<cr>",
				desc = "Show references",
			},
			{
				"<leader>ci",
				"<cmd>Trouble lsp_implementations focus=true<cr>",
				desc = "Show implementations",
			},
			{
				"<leader>cd",
				"<cmd>Trouble lsp_definitions focus=true<cr>",
				desc = "Show definitions",
			},
		},
		config = function()
			require("config._lsp_trouble").config()
		end,
	},
	{
		"stevearc/aerial.nvim",
		keys = {
			{ "<F2>", "<cmd>AerialToggle<cr>", { "n", "i" } },
		},
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	require("lsp.lsp_ts").ts_tools,
	{
		"jay-babu/mason-null-ls.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			{
				"nvimtools/none-ls.nvim",
				dependencies = {
					"gbprod/none-ls-luacheck.nvim",
				},
			},
		},
		config = function()
			require("lsp.lsp_nullls").config()
		end,
	},
	{
		"wojciech-kulik/xcodebuild.nvim",
		enabled = false,
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("xcodebuild").setup({
				-- put some options here or leave it empty to use default settings
			})
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		enabled = mxvim.enable_action_preview,
		event = "VeryLazy",
		config = function()
			vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions, { desc = "Code action" })
			require("actions-preview").setup({
				telescope = require("telescope.themes").get_dropdown({ winblend = 10 }),
			})
		end,
	},
	{
		"dnlhc/glance.nvim",
		event = "VeryLazy",
		config = function()
			require("glance").setup({
				-- your configuration
			})
			-- Lua
			vim.keymap.set("n", "<leader>cgd", "<CMD>Glance definitions<CR>")
			vim.keymap.set("n", "<leader>cgr", "<CMD>Glance references<CR>")
			vim.keymap.set("n", "<leader>cgy", "<CMD>Glance type_definitions<CR>")
			vim.keymap.set("n", "<leader>cgm", "<CMD>Glance implementations<CR>")
		end,
	},
}