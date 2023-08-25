local g = vim.g

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.cmd([[ com! PS lua require('lazy').sync() ]])

require("lazy").setup({
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },

	require("theme").theme("Mofiqul/vscode.nvim", "vscode"),
	require("theme").theme("projekt0n/github-nvim-theme", "github-theme"),
	require("theme").theme("bluz71/vim-nightfly-guicolors", "nightfly"),
	require("theme").theme("PangPangPangPangPang/miramare", "miramare"),
	require("theme").theme("shaunsingh/nord.nvim", "nord"),
	require("theme").theme("olimorris/onedarkpro.nvim", "onedarkpro"),
	require("theme").theme("rose-pine/neovim", "rose-pine"),
	require("theme").theme("catppuccin/nvim", "catppuccin"),
	require("theme").theme("sainnhe/gruvbox-material", "gruvbox-material"),
	require("theme").theme("rebelot/kanagawa.nvim", "kanagawa"),
	require("theme").theme("EdenEast/nightfox.nvim", "nightfox"),
	require("theme").theme("sam4llis/nvim-tundra", "tundra"),
	require("theme").theme("luisiacc/gruvbox-baby", "gruvbox-baby"),
	require("theme").theme("PangPangPangPangPang/oh-lucy.nvim", "oh-lucy"),
	require("theme").theme("savq/melange-nvim", "melange"),
	require("theme").theme("AlexvZyl/nordic.nvim", "nordic"),
	require("theme").theme("loctvl842/monokai-pro.nvim", "monokai"),
	{ "drmikehenry/vim-fixkey" },
	{
		"glepnir/galaxyline.nvim",
		enabled = mxvim.current_line == "galaxy",
		branch = "main",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"bercly0b/lualine-lsp-progress",
		},
		enabled = mxvim.current_line == "lualine",
	},
	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		}
	},

	{
		"ZSaberLv0/ZFVimIM",
		lazy = true,
		keys = {
			{ "<M-i>", "<cmd>lua toggle_zfvimim()<cr>",  mode = "n" },
			{ "<M-i>", "<c-o>:lua toggle_zfvimim()<cr>", mode = "i" },
		},
		dependencies = {
			"ZSaberLv0/ZFVimJob",
			"ZSaberLv0/ZFVimGitUtil",
			"PangPangPangPangPang/ZFVimIM_pinyin",
			"ZSaberLv0/ZFVimIM_openapi",
		},
		init = function()
			require("config._zfvimim").setup()
		end,
		config = function()
			require("config._zfvimim").config()
		end,
	},
	-- Readline style insertion
	{ "tpope/vim-rsi" },

	{ "kevinhwang91/nvim-bqf", ft = "qf", branch = "main" },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = 'kevinhwang91/promise-async',
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._other").ufo_config(0)
		end
	},

	-- commenter
	{
		"tpope/vim-commentary",
		config = function()
			vim.g.kommentary_create_default_mappings = false
			vim.api.nvim_set_keymap("n", "<leader>/", "gcc", {})
			vim.api.nvim_set_keymap("v", "<leader>/", "gc", {})
		end,
	},
	{
		"luochen1990/rainbow",
		enabled = not mxvim.enable_treesitter,
		lazy = true,
		event = "VimEnter",
		init = function()
			local colors = require("theme").theme_colors()
			g.rainbow_active = 1
			g.rainbow_conf = { guifgs = { colors.magenta, colors.cyan, colors.purple, colors.yellow } }
		end,
		config = function()
			vim.cmd("RainbowToggleOn")
		end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = mxvim.enable_treesitter,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/playground",
			"HiPhish/nvim-ts-rainbow2",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
			"m-demare/hlargs.nvim",
		},
		build = ":TSUpdate",
		config = function()
			require("config._treesitter")
			require("config._treesitter").inithlargs()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("config._autopairs").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._indentline").setup()
		end,
	},

	{ "tpope/vim-surround" },

	{
		"mhinz/vim-grepper",
		lazy = true,
		event = "VeryLazy",
		init = function()
			require("config._grep").setup()
		end,
	},

	{
		"pmizio/typescript-tools.nvim",
		enabled = false,
		lazy = true,
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("lsp.lsp_ts").config()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			{ "williamboman/mason.nvim",  lazy = true },
			{ "nvim-lua/lsp-status.nvim", lazy = true },
			{
				"neovim/nvim-lspconfig",
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
			"hrsh7th/cmp-nvim-lsp-signature-help",
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
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		enabled = false,
		-- cmd = { "SymbolsOutline" },
	},
	{
		"karb94/neoscroll.nvim",
		enabled = not g.neovide,
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._neoscroll").config()
		end,
	},
	{
		"lewis6991/satellite.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._scrollbar").config()
		end,
	},

	-- debugger
	{
		"ravenxrz/nvim-dap",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"ravenxrz/DAPInstall.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-telescope/telescope-dap.nvim",
		},
	},

	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local actions = require "fzf-lua.actions"
			require('fzf-lua').setup {
				actions = {
					files = {
						["enter"]  = actions.file_edit,
						["ctrl-s"] = actions.file_split,
						["ctrl-v"] = actions.file_vsplit,
						["ctrl-t"] = actions.file_tabedit,
						["alt-q"]  = actions.file_sel_to_qf,
						["alt-l"]  = actions.file_sel_to_ll,
					}
				},
				files = {
					prompt = 'Files: ',
				}
			}
			local lmap = require("utils").map
			lmap("n", "<c-p>", ":lua require('fzf-lua').files()<cr>", { silent = true })
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build =
				'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
			}
		},
		keys = {
			{ "<c-p>",     "<cmd>Telescope find_files<cr>" },
			{ "<leader>f", "<cmd>Telescope live_grep<cr>", { "n" } },
		},
		config = function()
			require("config._telescope").config()
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		ft = { "markdown" },
	},

	{
		"voldikss/vim-floaterm",
		cmd = { "FloatermToggle", "FloatermNew" },
		keys = {
			{ "<F5>",       "<cmd>lua require('config._vim_floaterm').open_term()<cr>",        mode = "n" },
			{ "<F5>",       "<C-\\><C-n>:lua require('config._vim_floaterm').open_term()<CR>", mode = "t" },
			{ "<Esc>",      "<C-\\><C-n>:lua require('config._vim_floaterm').close()<CR>",     mode = "t" },
			{ "<leader>lg", ":lua require('config._vim_floaterm').open_lazygit()<CR>",         mode = "n" },
		},
		config = function()
			require("config._vim_floaterm").map()
		end,
	},

	{
		"RishabhRD/nvim-cheat.sh",
		lazy = true,
		config = function()
			vim.g.cheat_default_window_layout = "float"
		end,
		cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
		dependencies = {
			"RishabhRD/popfix",
		},
	},

	{
		"szw/vim-maximizer",
		cmd = { "MaximizerToggle" },
		init = function()
			local lmap = require("utils").map
			lmap("n", "<c-w>z", ":MaximizerToggle<CR>", { silent = true })
			lmap("v", "<c-w>z", ":MaximizerToggle<CR>gv", { silent = true })
		end,
	},

	{
		"romainl/vim-cool",
		init = function()
			g.CoolTotalMatches = 1
		end,
	},

	{
		"psliwka/vim-smoothie",
		enabled = false,
		init = function()
			g.smoothie_base_speed = 20
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._gitsigns").config()
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		enabled = not mxvim.enable_neotree,
		lazy = true,
		cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
		init = function()
			require("config._tree").init()
		end,
		keys = {
			{ "<F1>",      "<cmd>NvimTreeToggle<cr>",   mode = "n" },
			{ "<leader>j", "<cmd>NvimTreeFindFile<cr>", mode = { "n" } },
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

	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
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
		event = "VeryLazy",
	},
	{
		"rhysd/git-messenger.vim",
		cmd = { "GitMessenger" },
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"cl",
				mode = { "n", "x", "o" },
				function()
					require("config._flash").jump()
					-- require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"chentoast/marks.nvim",
		enabled = false,
		lazy = true,
		config = function()
			require("config._mark").config()
		end,
	},

	{
		"justinmk/vim-sneak",
		enabled = false,
		lazy = true,
		config = function()
			require("config._sneak").config()
		end,
	},
	{
		"kshenoy/vim-signature",
		enabled = false,
		lazy = true,
	},

	{
		"simnalamburt/vim-mundo",
		cmd = { "MundoToggle" },
		keys = {
			{ "<F7>", "<cmd>MundoToggle<cr>", mode = "n" },
		},
	},

	-- html
	{
		"mattn/emmet-vim",
		ft = { "css", "javascriptreact", "html", "typescriptreact" },
		init = function()
			g.user_emmet_expandabbr_key = "<C-y><tab>"
			g.user_emmet_prev_key = "<C-y>p"
		end,
	},

	{ "tpope/vim-dadbod",  cmd = { "DB" } },
	{
		"skywind3000/vim-quickui",
		lazy = true,
		event = "VeryLazy",
		init = function()
			g.quickui_border_style = 2
			g.quickui_color_scheme = "system"
		end,
	},

	{
		-- "~/bilibili_live_broadcast",
		"PangPangPangPangPang/bilibili_live_broadcast",
		enabled = false,
		lazy = true,
		cmd = { "BiliLive" },
		config = function()
			require("config._bili_live").config()
		end,
		dependencies = { "rcarriga/nvim-notify" },
	},
	{
		"PangPangPangPangPang/prettier-number-line.nvim",
		lazy = true,
		event = "VimEnter",
		config = function()
			-- current virtual
			require("prettier-number-line").setup({
				mode = "current",
				show_col = false,
				exclusive_filetype = { "fugitive" },
				col_highlight = "VertSplit",
			})
		end,
	},
	{
		"github/copilot.vim",
		enabled = false,
		lazy = true,
	},

	{
		"b0o/incline.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._incline").config()
		end,
	},
	{
		"ybian/smartim",
		lazy = true,
		-- event = { "InsertEnter" },
		config = function()
			-- default IME mode
			vim.g.smartim_default = "com.apple.keylayout.ABC"
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		lazy = true,
		cmd = { "ChatGPT" },
		config = function()
			require("chatgpt").setup({
				keymaps = {
					close = { "<C-c>" },
					submit = "<C-e>",
					yank_last = "<C-y>",
					yank_last_code = "<C-k>",
					scroll_up = "<C-u>",
					scroll_down = "<C-d>",
					toggle_settings = "<C-o>",
					new_session = "<C-n>",
					cycle_windows = "<Tab>",
					-- in the Sessions pane
					select_session = "<Space>",
					rename_session = "r",
					delete_session = "d",
				},

				-- optional configuration
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
})