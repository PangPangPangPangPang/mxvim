local lualine = require("lualine")
local colors = require("theme").theme_colors()

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
		icons_enabled = true,

		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
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

ins_left({
	function()
		return "▊"
	end,
	padding = { right = 1 },
	color = { fg = colors.fg_green },
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
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
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
		return { fg = mode_color[vim.fn.mode()], gui = "bold" }
	end,
	padding = { right = 1 },
})
ins_left({
	"filetype",
	colored = true, -- Displays filetype icon in color if set to true
	icon_only = true, -- Display only an icon for filetype
	-- icon = { align = "right" }, -- Display filetype icon on the right hand sid
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.fg, gui = "bold" },
})

ins_left({
	"filesize",
})
ins_left({
    function ()
        return " "
    end
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
		globalstatus = true,
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

lualine.setup(normal_config)
