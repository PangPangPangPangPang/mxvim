local M = {}
M.config = function()
	local actions = require "fzf-lua.actions"
	require('fzf-lua').setup {
		"default",
		fzf_colors = {
			["fg+"]     = { "fg", "Normal" },
			["bg+"]     = { "bg", "CursorLine" },
			["info"]    = { "fg", "Float" },
			["pointer"] = { "fg", "ErrorMsg" },
			["spinner"] = { "fg", "ErrorMsg" },
			["header"]  = { "fg", "Comment" },
			["gutter"]  = { "bg", "Normal" },
		},
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
			prompt = "   ",
			file_icons = true,
			cwd_prompt = false,
			fzf_opts = {
				['--info'] = 'default', -- inline
				-- ['--separator'] = " ",
				['--no-scrollbar'] = ""
			},
		},
		winopts = {
			preview = {
				layout = "vertical",
			}
		},
		git = {
			files = {
				prompt = "asd"
			}
		}
	}
	vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "Directory" })
	vim.api.nvim_set_hl(0, "FzfLuaTitle", { link = "Float" })
	local lmap = require("utils").map
end
return M