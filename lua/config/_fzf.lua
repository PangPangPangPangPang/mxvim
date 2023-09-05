local M = {}
M.config = function()
	local actions = require "fzf-lua.actions"
	require('fzf-lua').setup {
		"default",
		fzf_colors = {
          ["fg"]          = { "fg", "CursorLine" },
          ["bg"]          = { "bg", "Normal" },
          ["hl"]          = { "fg", "Redfg" },
          ["fg+"]         = { "fg", "Blackfg" },
          ["bg+"]         = { "bg", "Greenbg" },
          ["hl+"]         = { "fg", "Redfg" },
          ["info"]        = { "fg", "PreProc" },
          ["prompt"]      = { "fg", "Conditional" },
          ["pointer"]     = { "fg", "Execption" },
          ["marker"]      = { "fg", "Keyword" },
          ["spinner"]     = { "fg", "Float" },
          ["header"]      = { "fg", "Comment" },
          ["gutter"]      = { "bg", "Normal" },
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
	}
	vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "Directory" })
	vim.api.nvim_set_hl(0, "FzfLuaTitle", { link = "Float" })
	vim.api.nvim_set_hl(0, "FzfLuaCursor", { link = "Float" })
	vim.api.nvim_set_hl(0, "FzfLuaCursorLine", { link = "Float" })
	vim.api.nvim_set_hl(0, "FzfLuaCursorLineNr", { link = "Float" })
end
return M