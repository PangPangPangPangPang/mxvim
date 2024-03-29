local present, lualine = pcall(require, "lualine")
if not present then
	return
end

vim.api.nvim_create_autocmd({ "DirChanged", "TabEnter"}, {
    pattern = "*",
    callback = function ()
        vim.cmd(string.format("LualineRenameTab %s", vim.fn.getcwd(0)))
    end
})

local colors = require("theme").colors()
local shade_bg = require("theme").shade(colors.bg, 0.2, true)

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
		disabled_filetypes = { "NvimTree" },
		icons_enabled = true,

		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		-- section_separators = { right = " | " },
		theme = {
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
	tabline = {
		lualine_a = {
			{
				"tabs",
				max_length = vim.o.columns / 3,
				mode = 2,
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {
			{
				"buffers",
				buffers_color = {
					active = { fg = colors.fg, bg = colors.bg, gui = "bold" },
					inactive = { fg = shade_fg, bg = colors.bg, },
				},
			},
		},
	},
	extensions = {
		"fugitive",
		"toggleterm",
		"quickfix",
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_z, component)
end

local function ins_inactive_left(component)
	table.insert(config.inactive_sections.lualine_c, component)
end

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
	colored = true,
	icon_only = true,
})
ins_left({
	"filename",
	padding = { right = 1 },
	cond = conditions.buffer_not_empty,
	color = { fg = colors.fg, gui = "bold" },
	symbols = {
		modified = "  ",
		readonly = "  ",
		unnamed = "[No Name]",
	},
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

-- center
ins_left({ "%=" })

local icons = require("theme").lsp_icon
ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic", "coc" },
	sections = { "error", "warn", "info", "hint" },
	diagnostics_color = {
		error = { fg = colors.red },
		warn = { fg = colors.orange },
		info = { fg = colors.blue },
		hint = { fg = colors.cyan },
	},
	symbols = { error = icons.error, warn = icons.warn, info = icons.info, hint = icons.hint },
	colored = true,
	update_in_insert = false,
	always_visible = false,
})
ins_right({
	"location",
	padding = { left = 1 },
	color = { fg = colors.fg },
})
ins_right({
	function()
		return " | "
	end,
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
	color = mode_color,
})

ins_inactive_left({
	"filetype",
	icon_only = true,
	color = { fg = shade_fg, gui = "bold" },
})
ins_inactive_left({
	"filename",
	padding = { right = 1 },
	cond = conditions.buffer_not_empty,
	color = { fg = shade_fg, gui = "bold" },
})

lualine.setup(config)

vim.cmd[[
    set showtabline=1
]]