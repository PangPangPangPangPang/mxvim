local gl = require("galaxyline")
local gls = gl.section

gl.short_line_list = {
	"LuaTree",
	"vista",
	"dbui",
	"startify",
	"term",
	"nerdtree",
	"fugitive",
	"fugitiveblame",
	"plug",
	"defx",
	"NvimTree",
}
local function get_hunks_data()
  -- diff data 1:add 2:modified 3:remove
  local diff_data = {0,0,0}
  if vim.fn.exists('*GitGutterGetHunkSummary') == 1 then
    for idx,v in pairs(vim.fn.GitGutterGetHunkSummary()) do
      diff_data[idx] = v
    end
    return diff_data
  elseif vim.fn.exists('*sy#repo#get_stats') == 1 then
    diff_data[1] = vim.fn['sy#repo#get_stats']()[1]
    diff_data[2] = vim.fn['sy#repo#get_stats']()[2]
    diff_data[3] = vim.fn['sy#repo#get_stats']()[3]
    return diff_data
  elseif vim.fn.exists('b:gitsigns_status') == 1 then
    local gitsigns_dict = vim.api.nvim_buf_get_var(0, 'gitsigns_status')
    diff_data[1] = tonumber(gitsigns_dict:match('+(%d+)')) or 0
    diff_data[2] = tonumber(gitsigns_dict:match('~(%d+)')) or 0
    diff_data[3] = tonumber(gitsigns_dict:match('-(%d+)')) or 0
  end
  return diff_data
end
local checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	if squeeze_width > 40 then
		return true
	end
	return false
end

local function get_hunk_data(index)
    local data = get_hunks_data()[index]
    if data > 0 then
        return data
    end
end
local function has_hunk_data()
    if get_hunks_data()[1] > 0 or get_hunks_data()[2] > 0 or get_hunks_data()[3] > 0 then
        return true
    end
    return false
end


local colors = require("theme").theme_colors()

vim.api.nvim_command("hi! StatusLine guibg=" .. colors.bg .. " guifg=" .. colors.bg)

local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

local function file_readonly(readonly_icon)
	if vim.bo.filetype == "help" then
		return ""
	end
	local icon = readonly_icon or ""
	if vim.bo.readonly == true then
		return " " .. icon .. " "
	end
	return ""
end

local get_current_file_name = function(modified_icon, readonly_icon)
	local file = vim.fn.expand("%:t")
	if vim.fn.empty(file) == 1 then
		return ""
	end
	if string.find(file, "index") then
		file = vim.fn.expand("%")
	end
	if string.len(file_readonly(readonly_icon)) ~= 0 then
		return file .. file_readonly(readonly_icon)
	end
	local icon = modified_icon or ""
	if vim.bo.modifiable then
		if vim.bo.modified then
			return file .. " " .. icon .. "  "
		end
	end
	return file .. " "
end

gls.left[1] = {
	FirstElement = {
		provider = function()
			return "▊"
		end,
		separator = " ",
	},
}
gls.left[2] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
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
			local vim_mode = vim.fn.mode()
			vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim_mode])
			return alias[vim_mode] .. "  "
		end,
		highlight = { colors.red, colors.bg, "bold" },
	},
}
gls.left[3] = {
	FileIcon = {
		provider = "FileIcon",
		condition = buffer_not_empty,
		highlight = {
			require("galaxyline.providers.fileinfo").get_file_icon_color,
			colors.bg,
		},
	},
}
gls.left[4] = {
	FileName = {
		provider = { get_current_file_name, "FileSize" },
		condition = buffer_not_empty,
		highlight = { colors.fg, colors.bg, "bold" },
	},
}
gls.left[5] = {
	GitIcon = {
		provider = function()
			return "    "
		end,
		condition = require("galaxyline.providers.vcs").check_git_workspace,
		highlight = { colors.orange, colors.bg },
	},
}
gls.left[6] = {
	GitBranch = {
		provider = "GitBranch",
		condition = require("galaxyline.providers.vcs").check_git_workspace,
		highlight = { colors.orange, colors.bg, "bold" },
	},
}
gls.left[7] = {
	DiffLeft = {
		provider = function ()
            if has_hunk_data() then
                return '('
            end
		end,
		condition = checkwidth,
		highlight = { colors.purple, colors.bg },
	},
}
gls.left[8] = {
	DiffAdd = {
		provider = function ()
		    return get_hunk_data(1)
		end,
		condition = checkwidth,
		separator = "",
		icon = "+",
		highlight = { colors.green, colors.bg },
	},
}

gls.left[9] = {
	DiffRemove = {
		provider = function ()
		    return get_hunk_data(3)
		end,
		condition = checkwidth,
		separator = "",
		icon = "-",
		highlight = { colors.red, colors.bg },
	},
}

gls.left[10] = {
	DiffModified = {
		provider = function ()
		    return get_hunk_data(2)
		end,
		condition = checkwidth,
		separator = "",
		icon = "~",
		highlight = { colors.yellow, colors.bg },
	},
}

gls.left[11] = {
	DiffRight = {
		provider = function ()
            if has_hunk_data() then
                return ')'
            end
		end,
		condition = checkwidth,
		highlight = { colors.purple, colors.bg },
	},
}
gls.mid[0] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "    ",
		highlight = { colors.red, colors.bg },
	},
}
gls.mid[1] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "    ",
		highlight = { colors.yellow, colors.bg },
	},
}
gls.mid[2] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "    ",
		highlight = { colors.purple, colors.bg },
	},
}

gls.mid[3] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = "    ",
		highlight = { colors.cyan, colors.bg },
	},
}

gls.right[1] = {
	FileFormat = {
		provider = "FileFormat",
		separator = " ",
		separator_highlight = { colors.bg, colors.bg },
		highlight = { colors.yellow, colors.bg, "bold" },
	},
}
gls.right[2] = {
	LineInfo = {
		provider = "LineColumn",
		separator = " | ",
		separator_highlight = { colors.purple, colors.bg },
		highlight = { colors.fg, colors.bg },
	},
}

gls.right[3] = {
	FirstElement = {
		provider = function()
			return "▊"
		end,
		separator = " ",
		highlight = { colors.fg_green, colors.bg },
	},
}


local function file_name()
	local name = get_current_file_name()
	if string.find(name, "NvimTree", 1) ~= nil then
		return "FileTree"
	end
	return get_current_file_name()
end

local function has_file_type()
	local f_type = vim.bo.filetype
	if not f_type or f_type == "" then
		return false
	end
	return true
end

local function has_file_type_and_other()
	local f_type = vim.bo.filetype
	if not f_type or f_type == "" or f_type == "NvimTree" then
		return false
	end
	return true
end

local shade_bg = require("theme").shade_all(colors.bg, 0.2)
local shade_fg = require("theme").shade_all(colors.fg, 0.5)

gls.short_line_left[1] = {
	FileIconShort = {
		icon = " ",
		provider = "FileIcon",
		condition = has_file_type_and_other,
		highlight = {
			shade_fg,
			shade_bg,
		},
	},
}
gls.short_line_left[2] = {
	BufferType = {
		provider = { file_name },
		condition = has_file_type,
		separator_highlight = { colors.purple, shade_bg },
		highlight = { shade_fg, shade_bg },
	},
}

gls.short_line_right[1] = {
	BufferIcon = {
		provider = "BufferIcon",
		separator = "",
		condition = has_file_type,
		separator_highlight = { colors.purple, shade_bg },
		highlight = { colors.fg, shade_bg },
	},
}
