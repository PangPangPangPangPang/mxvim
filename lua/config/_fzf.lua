local M = {}
M.config = function()
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
return M