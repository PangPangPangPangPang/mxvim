vim.o.laststatus = 3
local present, lualine = pcall(require, "lualine")
if not present then
	return
end

vim.api.nvim_create_autocmd({ "DirChanged", "TabEnter" }, {
	pattern = "*",
	callback = function()
		vim.cmd(string.format("LualineRenameTab %s", vim.fn.getcwd(0)))
	end,
})

local colors = require("theme").colors()

local fg = colors.line_fg

local bubbles_theme = {
  normal = { a = { fg = fg, bg = 'none', gui = "bold" } },
  insert = { a = { fg = fg, bg = 'none', gui = "bold" } },
  visual = { a = { fg = fg, bg = 'none', gui = "bold" } },
  replace = { a = { fg = fg, bg = 'none', gui = "bold" } },
  terminal = { a = { fg = fg, bg = 'none', gui = "bold" } },
  command = { a = { fg = fg, bg = 'none', gui = "bold" } },

}
local config = {
	options = {
		-- disabled_filetypes = { "NvimTree" },
		icons_enabled = true,

		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = bubbles_theme,
		-- section_separators = { right = " | " },
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
				mode = 0,
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {
			{
				"buffers",
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
	table.insert(config.sections.lualine_a, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_z, component)
end

local function ins_inactive_left(component)
	table.insert(config.inactive_sections.lualine_c, component)
end

ins_left({
	"diff",
	padding = { right = 2 },
	colored = false,
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
		-- return alias[vim.fn.mode()]
		return string.format("%s", alias[vim.fn.mode()])
	end,
	padding = { left = 1 },
})

ins_right({
	"lsp_progress",
	display_components = { "lsp_client_name", { "title", "percentage", "message" } },
	display_lsp_name_after_initialization = true,
	separators = {
		component = " ",
		progress = " | ",
		percentage = { pre = "", post = "%% " },
		title = { pre = "", post = ": " },
		lsp_client_name = { pre = "", post = "" },
		spinner = { pre = "", post = "" },
		message = { commenced = "In Progress", completed = "Completed" },
	},
	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
	padding = { left = 2, right = 2 },
})
local function location()
	return "Ln%2l, Col%2v"
end

local zf = require("config._zfvimim")
ins_right({
	-- padding = { right = 2 },
	function()
		return zf.zf_method
	end,
})

local function search_count()
	local search = vim.fn.searchcount({ maxcount = 0 }) -- maxcount = 0 makes the number not be capped at 99
	local searchCurrent = search.current
	local searchTotal = search.total
	if searchCurrent > 0 then
		return vim.fn.getreg("/") .. " [" .. searchCurrent .. "/" .. searchTotal .. "]"
	else
		return ""
	end
end

ins_left({
	search_count,
	padding = { right = 2, left = 2 },
})
ins_left({
	location,
	padding = { right = 2, left = 2 },
})
ins_right({
	"filetype",
	-- colored = false,
	icons_enabled = false,
	icon_only = false,
	padding = { right = 2 },
})

local function encoding()
	return string.upper(vim.opt.fileencoding:get())
end
ins_right({
	encoding,
	icons_enabled = false,
	padding = { right = 2 },
})

ins_inactive_left({
	"filetype",
	icon_only = true,
})

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
ins_inactive_left({
	"filename",
	padding = { right = 2 },
	cond = conditions.buffer_not_empty,
})

lualine.setup(config)

vim.cmd([[
    set showtabline=1
]])