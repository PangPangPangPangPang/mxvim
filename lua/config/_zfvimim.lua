---@diagnostic disable: lowercase-global, undefined-global
local M = {}
M.setup = function()
	vim.g.ZFVimIM_keymap = 0
	vim.cmd([[
        let g:ZFVimIM_symbolMap = {'`' : ['·'],'!' : ['！'],'$' : ['￥'],'^' : ['……'],'-' : [''],'_' : ['——'],'(' : ['（'],')' : ['）'],'[' : ['【'],']' : ['】'],'<' : ['《'],'>' : ['》'],'\' : ['、'],'/' : ['、'],';' : ['；'],':' : ['：'],',' : ['，'],'.' : ['。'],'?' : ['？'],"'" : ['‘', '’'],'"' : ['“', '”'],}
    ]])

	vim.schedule(function()
		if vim.o.filetype == "markdown" then
			vim.cmd([[ PackerLoad ZFVimIM ]])
		end
	end)
	local map = require("utils").map
	local opts = { noremap = true, silent = true }
	map("i", "<c-k>", "<C-o>:lua toggle_zfvimim()<cr>", opts)
	vim.cmd([[
        autocmd User TelescopeFindPre lua stop_zfvimim()
    ]])
end
function stop_zfvimim()
	if packer_plugins["ZFVimIM"] and packer_plugins["ZFVimIM"].loaded then
		if vim.fn.ZFVimIME_started() == 1 then
			vim.fn.ZFVimIME_stop()
		end
	end
end

function toggle_zfvimim()
	if packer_plugins["ZFVimIM"] and packer_plugins["ZFVimIM"].loaded then
	else
		vim.cmd([[ PackerLoad ZFVimIM ]])
	end
	vim.fn.ZFVimIME_keymap_toggle_i()
end
M.config = function()
	M.setLocalDB()
end

M.setLocalDB = function()
	local fn = vim.fn
	if require("utils").is_module_available("private") == true then
		local db = fn.ZFVimIM_dbInit({ name = "MaxDB" })
		vim.fn.ZFVimIM_cloudRegister({
			mode = "local",
			dbId = db["dbId"],
			repoPath = "~/.config/nvim",
			dbFile = "/pinyin.txt",
		})
	end
end
return M
