local fn = vim.fn
local g = vim.g
local map = require("utils").map

-- for speedup start
pcall(require, "impatient")
-- vim.g.did_load_filetypes = 1
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- Automatically install packer.nvim
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

require("packer").init({ max_jobs = 60 })

require("packer").startup({
	function(use)
		-- -- Packer itself
		use({ "wbthomason/packer.nvim" })
		use({ "lewis6991/impatient.nvim" })
		-- use({ "nathom/filetype.nvim" })

		use({ "nvim-lua/popup.nvim" })
		use({ "nvim-lua/plenary.nvim" })

		use({
			require("theme").theme("Mofiqul/vscode.nvim"),
			require("theme").theme("projekt0n/github-nvim-theme"),
			require("theme").theme("bluz71/vim-nightfly-guicolors"),
			require("theme").theme("PangPangPangPangPang/miramare"),
			require("theme").theme("shaunsingh/nord.nvim"),
			require("theme").theme("olimorris/onedarkpro.nvim"),
			require("theme").theme("rose-pine/neovim", "rose-pine"),
			require("theme").theme("catppuccin/nvim", "catppuccin"),
			require("theme").theme("sainnhe/gruvbox-material"),
			require("theme").theme("rebelot/kanagawa.nvim"),
		})

		use({
			"NTBBloodbath/galaxyline.nvim",
			branch = "main",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use({
			"nanozuki/tabby.nvim",
			opt = true,
			requires = "kyazdani42/nvim-web-devicons",
			setup = function()
				require("config._tabby").setup()
			end,
			config = function()
				require("config._tabby").config()
			end,
		})
		use({
			"ZSaberLv0/ZFVimIM",
			opt = true,
			requires = {
				"ZSaberLv0/ZFVimJob",
				"ZSaberLv0/ZFVimGitUtil",
				"PangPangPangPangPang/ZFVimIM_pinyin",
				"ZSaberLv0/ZFVimIM_openapi",
			},
			setup = function()
				require("config._zfvimim").setup()
			end,
			config = function()
				require("config._zfvimim").config()
			end,
		})

		-- Readline style insertion
		use({ "tpope/vim-rsi" })

		use({ "kevinhwang91/nvim-bqf", ft = "qf", branch = "main" })

		-- commenter
		use({
			"tpope/vim-commentary",
			config = function()
				vim.g.kommentary_create_default_mappings = false
				vim.api.nvim_set_keymap("n", "<leader>/", "gcc", {})
				vim.api.nvim_set_keymap("v", "<leader>/", "gc", {})
			end,
		})

		if mxvim.use_treesitter then
			use({
				"nvim-treesitter/nvim-treesitter",
				requires = {
					"nvim-treesitter/nvim-treesitter-textobjects",
					"m-demare/hlargs.nvim",
					"p00f/nvim-ts-rainbow",
					"windwp/nvim-ts-autotag",
					"JoosepAlviste/nvim-ts-context-commentstring",
					"nvim-treesitter/playground",
				},
				run = ":TSUpdate",
				config = function()
					require("config._treesitter")
				end,
			})
		else
			use({ "sheerun/vim-polyglot" })
			use({ "luochen1990/rainbow" })
			g.rainbow_active = 1
		end

		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("config._indentline").setup()
			end,
		})

		use({ "tpope/vim-surround" })

		use({
			"mhinz/vim-grepper",
			fn = { "GrepperOperator" },
			cmd = { "GrepperRg", "Grepper" },
			setup = function()
				require("config._grep").setup()
			end,
		})

		if mxvim.use_coc == true then
			use({
				"neoclide/coc.nvim",
				branch = "release",
				config = function()
					require("config._coc").config()
				end,
			})

			use({ "rrethy/vim-hexokinase", run = "make hexokinase" })
			use({ "honza/vim-snippets" })
			use({
				"sbdchd/neoformat",
				cmd = "Neoformat",
				setup = function()
					require("config._neoformat").config()
				end,
			})
		else
			use({
				"williamboman/nvim-lsp-installer",
				opt = true,
				requires = {
					{ "RishabhRD/popfix", opt = true },
					{ "RishabhRD/nvim-lsputils", opt = true },
					{
						"ray-x/lsp_signature.nvim",
						disable = true,
						opt = true,
						config = function()
							require("config._signature").signature()
						end,
					},
					{
						"neovim/nvim-lspconfig",
						opt = true,
						config = function()
							require("config._lsp_config").config()
						end,
					},
				},
				setup = function()
					require("config._lsp_installer").setup()
				end,
				config = function()
					require("config._lsp_installer").config()
				end,
			})
			use({
				"j-hui/fidget.nvim",
				-- opt = true,
				config = function()
					require("fidget").setup({})
				end,
			})
			use({
				"https://gitlab.com/yorickpeterse/nvim-dd.git",
				opt = true,
				setup = function()
					require("config._other").dd_setup()
				end,
				config = function()
					require("dd").setup({
						timeout = 0,
					})
				end,
			})
			use({
				"jose-elias-alvarez/null-ls.nvim",
				opt = true,
				requires = { "neovim/nvim-lspconfig" },
				setup = function()
					require("lsp.lsp_nullls").setup()
				end,
				config = function()
					require("lsp.lsp_nullls").config()
				end,
			})
			use({
				"hrsh7th/nvim-cmp",
				opt = true,
				requires = {
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
						wants = "friendly-snippets",
						requires = {
							"hrsh7th/vim-vsnip-integ",
							"hrsh7th/vim-vsnip",
							"rafamadriz/friendly-snippets",
						},
					},
					{
						"quangnguyen30192/cmp-nvim-tags",
						-- if you want the sources is available for some file types
						ft = {
							"javascriptreact",
							"typescriptreact",
							"javascript",
							"typescript",
							"lua",
						},
					},
				},
				setup = function()
					require("config._nvim_cmp").setup()
				end,
				config = function()
					require("config._nvim_cmp").config()
				end,
			})
			use({
				"ms-jpq/coq_nvim",
				opt = true,
				branch = "coq",
				requires = {
					{ "ms-jpq/coq.artifacts", branch = "artifacts" },
				},
				setup = function()
					require("config._coq").setup()
				end,
				config = function()
					require("config._coq").config()
				end,
			}) -- main one

			use({
				"tami5/lspsaga.nvim",
				opt = true,
				setup = function()
					require("config._lsp_saga").setup()
				end,
				config = function()
					require("config._lsp_saga").config()
				end,
			})
			use({
				"petertriho/nvim-scrollbar",
				opt = true,
				setup = function()
					require("config._scrollbar").setup()
				end,
				config = function()
					require("config._scrollbar").config()
				end,
			})

			use({
				"folke/lsp-trouble.nvim",
				cmd = { "LspTrouble", "Trouble" },
				config = function()
					require("config._lsp_trouble").config()
				end,
			})

			use({
				"norcalli/nvim-colorizer.lua",
				opt = true,
				setup = function()
					require("config._other").colorizer_setup()
				end,
				config = function()
					require("colorizer").setup()
				end,
			})

			use({
				"simrat39/symbols-outline.nvim",
				cmd = { "SymbolsOutline" },
				setup = function()
					require("config._outline").config()
				end,
			})
		end

		-- use({
		-- 	"jiangmiao/auto-pairs",
		-- })
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("config._autopairs").setup()
			end,
		})

		use({ "tweekmonster/startuptime.vim", cmd = { "StartupTime" } })

		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			},
			cmd = { "Telescope" },
			config = function()
				require("config._telescope").config()
			end,
			setup = function()
				require("config._telescope").map()
			end,
		})

		use({
			"iamcco/markdown-preview.nvim",
			-- disable = true,
			run = "cd app && yarn install",
			-- cmd = { "MarkdownPreview" },
		})

		use({
			"voldikss/vim-floaterm",
			cmd = { "FloatermToggle", "FloatermNew" },
			setup = function()
				require("config._vim_floaterm").map()
			end,
		})

		use({
			"RishabhRD/nvim-cheat.sh",
			opt = true,
			config = function()
				vim.g.cheat_default_window_layout = "float"
			end,
			cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
			requires = {
				"RishabhRD/popfix",
			},
		})

		use({
			"szw/vim-maximizer",
			cmd = { "MaximizerToggle" },
			setup = function()
				local lmap = require("utils").map
				lmap("n", "<c-w>z", ":MaximizerToggle<CR>", { silent = true })
				lmap("v", "<c-w>z", ":MaximizerToggle<CR>gv", { silent = true })
			end,
		})

		g.CoolTotalMatches = 1
		use({ "romainl/vim-cool" })

		g.smoothie_base_speed = 20
		use({
			disable = true,
			"psliwka/vim-smoothie",
		})

		use({
			"lewis6991/gitsigns.nvim",
			opt = true,
			setup = function()
				require("config._gitsigns").setup()
			end,
			config = function()
				require("config._gitsigns").config()
			end,
		})
		use({
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
			opt = true,
			-- cmd = {'NvimTreeToggle', 'NvimTreeFindFile'},
			config = function()
				require("config._tree").config()
			end,
			setup = function()
				require("config._tree").setup()
			end,
		})

		use({
			"tpope/vim-fugitive",
			opt = true,
			setup = function()
				require("config._fugitive").setup()
			end,
		})
		use({ "rbong/vim-flog" })
		use({
			"rhysd/git-messenger.vim",
			cmd = { "GitMessenger" },
		})

		use({
			"ggandor/lightspeed.nvim",
			opt = true,
			setup = function()
				require("config._other").setup_lightspeed()
			end,
		})

		use({
			"justinmk/vim-sneak",
			disable = true,
			opt = true,
			setup = function()
				require("config._sneak").setup()
			end,
			config = function()
				require("config._sneak").config()
			end,
		})
		use({
			"kshenoy/vim-signature",
			opt = true,
			setup = function()
				require("config._other").signature_setup()
			end,
		})

		use({ "simnalamburt/vim-mundo", cmd = { "MundoToggle" } })
		map("n", "<F6>", ":MundoToggle<CR>", { silent = true })

		-- html
		use({
			"mattn/emmet-vim",
			ft = { "css", "javascriptreact", "html", "typescriptreact" },
		})
		g.user_emmet_expandabbr_key = "<C-y><tab>"
		g.user_emmet_prev_key = "<C-y>p"

		use({ "tpope/vim-dadbod", cmd = { "DB" } })
		use({ "skywind3000/vim-quickui" })
		g.quickui_border_style = 2
		g.quickui_color_scheme = "system"

		use({
			-- "~/bilibili_live_broadcast",
			"PangPangPangPangPang/bilibili_live_broadcast",
			opt = true,
			cmd = { "BiliLive" },
			config = function()
				require("config._bili_live").config()
			end,
			requires = { "rcarriga/nvim-notify" },
		})

		use({
			"PangPangPangPangPang/prettier-number-line.nvim",
			config = function()
				-- current virtual
				require("prettier-number-line").setup({ mode = "current", exclusive_filetype = { "fugitive" } })
			end,
		})

		use({
			"github/copilot.vim",
			disable = true,
			opt = true,
			setup = function()
				require("config._other").copilot_setup()
			end,
		})

		if packer_bootstrap then
			require("packer").sync()
		end
		use({ "SolaWing/vim-objc-syntax", ft = { "objc", "objcpp" } })
	end,
	config = {
		auto_clean = true,
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		compile_path = mxvim.compile_path,
	},
})

-- for impatient
require("packer_compiled")
