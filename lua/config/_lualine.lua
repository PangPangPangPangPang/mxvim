local lualine = require("lualine")
local colors = require("theme").theme_colors()
local shade_bg = require("theme").shade_all(colors.bg, 0.2)
local shade_fg = require("theme").shade_all(colors.fg, 0.5)

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		disabled_filetypes = { "NvimTree", "fugitive" },
		icons_enabled = true,

		-- Disable sections and component separators
		-- component_separators = { right = " | " },
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = {
				a = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
				x = { fg = colors.fg, bg = colors.bg },
				z = { fg = colors.fg, bg = colors.bg },
			},
			inactive = {
				a = { fg = shade_fg, bg = shade_bg },
				c = { fg = shade_fg, bg = shade_bg },
				x = { fg = shade_fg, bg = shade_bg },
				z = { fg = shade_fg, bg = shade_bg },
			},
		},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

local function ins_inactive_left(component)
	table.insert(config.inactive_sections.lualine_c, component)
end

ins_inactive_left("filename")

local function mode_color()
	local color = {
		n = colors.green,
		i = colors.blue,
		v = colors.magenta,
		[""] = colors.blue,
		V = colors.blue,
		no = colors.magenta,
		s = colors.orange,
		S = colors.orange,
		[""] = colors.orange,
		ic = colors.yellow,
		cv = colors.red,
		ce = colors.red,
		["!"] = colors.green,
		t = colors.green,
		c = colors.purple,
		["r?"] = colors.red,
		["r"] = colors.red,
		rm = colors.red,
		R = colors.yellow,
		Rv = colors.magenta,
	}
	return { fg = color[vim.fn.mode()], gui = "bold" }
end

ins_left({
	function()
		return "▊"
	end,
	padding = { right = 1 },
	color = mode_color,
})
ins_left({
	-- mode component
	function()
		local alias = {
			n = "NORMAL",
			i = "INSERT",
			V = "VISUAL",
			[""] = "VISUAL",
			v = "VISUAL",
			c = "COMMAND-LINE",
			["r?"] = ":CONFIRM",
			rm = "--MORE",
			R = "REPLACE",
			Rv = "VIRTUAL",
			s = "SELECT",
			S = "SELECT",
			["r"] = "HIT-ENTER",
			[""] = "SELECT",
			t = "TERMINAL",
			["!"] = "SHELL",
		}
		return alias[vim.fn.mode()]
	end,
	color = mode_color,
	padding = { right = 2 },
})
ins_left({
	"filetype",
	colored = true, -- Displays filetype icon in color if set to true
	icon_only = true, -- Display only an icon for filetype
	-- icon = { align = "right" }, -- Display filetype icon on the right hand sid
})

ins_left({
	"filename",
	padding = { right = 1 },
	cond = conditions.buffer_not_empty,
	color = { fg = colors.fg, gui = "bold" },
})

ins_left({
	"filesize",
	padding = { right = 1 },
})

ins_left({
	"branch",
	icon = "  ",
	color = { fg = colors.orange, gui = "bold" },
})
ins_left({
	"diff",
	padding = { right = 1 },
})

ins_left({ "%=" })
ins_left({
	"diagnostics",
	-- Table of diagnostic sources, available sources are:
	--   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
	-- or a function that returns a table as such:
	--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
	sources = { "nvim_diagnostic", "coc" },

	-- Displays diagnostics for the defined severity types
	sections = { "error", "warn", "info", "hint" },

	diagnostics_color = {
		-- Same values as the general color option can be used here.
		error = { fg = colors.red },
		warn = { fg = colors.orange },
		info = { fg = colors.blue },
		hint = { fg = colors.cyan },
	},
	-- color = function()
	-- 	-- auto change color according to neovims mode
	-- 	return { bg = colors.bg }
	-- end,
	symbols = { error = "    ", warn = "    ", info = "    ", hint = "    " },
	colored = true, -- Displays diagnostics status in color if set to true.
	update_in_insert = false, -- Update diagnostics in insert mode.
	always_visible = false, -- Show diagnostics even if there are none.
})
ins_right({
	"location",
	color = { fg = colors.fg },
})
ins_right({
	"fileformat",
	padding = { right = 1 },
	color = { fg = colors.yellow },
})
ins_right({
	"encoding",
	padding = { right = 1 },
	color = { fg = colors.yellow },
})
ins_right({
	function()
		return "▊"
	end,
	padding = { left = 1 },
	color = mode_color
})

local normal_config = {
	options = {
		icons_enabled = true,
		theme = "auto",
		-- component_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		component_separators = "",
		section_separators = "",
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			"filename",
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
}

lualine.setup(config)
