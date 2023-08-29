return {
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
				bottom_search = false, -- use a classic bottom cmdline for search
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
		"luochen1990/rainbow",
		enabled = not mxvim.enable_treesitter,
		lazy = true,
		event = "VimEnter",
		init = function()
			local colors = require("theme").theme_colors()
			vim.g.rainbow_active = 1
			vim.g.rainbow_conf = { guifgs = { colors.magenta, colors.cyan, colors.purple, colors.yellow } }
		end,
		config = function()
			vim.cmd("RainbowToggleOn")
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._indentline").setup()
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
		"lewis6991/satellite.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._scrollbar").config()
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
		"romainl/vim-cool",
		init = function()
			vim.g.CoolTotalMatches = 1
		end,
	},
	{
		"psliwka/vim-smoothie",
		enabled = false,
		init = function()
			vim.g.smoothie_base_speed = 20
		end,
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
		"PangPangPangPangPang/prettier-number-line.nvim",
		enabled = not mxvim.enable_statuscol,
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
		"b0o/incline.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config._incline").config()
		end,
	},
	{
		"luukvbaal/statuscol.nvim",
		lazy = true,
		event = "VimEnter",
		enabled = mxvim.enable_statuscol,
		config = function()
			vim.cmd([[hi! LineNr guifg=bg]])
			local statuscol = require "statuscol"
			local builtin = require "statuscol.builtin"
			statuscol.setup {
				bt_ignore = { "nofile", "terminal" },
				segments = {
					{
						text = { builtin.lnumfunc },
						-- sign = { name = { "Diagnostic" } },
					},
					{
						sign = { name = { "GitSigns" }, colwidth = 1, wrap = true },
						fillchar = "%#LineNr#%=│",
						click = "v:lua.ScSa",
					},
					-- { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				},
			}
		end,
	}
}