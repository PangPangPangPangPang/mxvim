---@diagnostic disable: lowercase-global, undefined-global
local M = {}
local is_zf_load = false
M.setup = function()
	vim.g.ZFVimIM_keymap = 0
	vim.cmd([[
        let g:ZFVimIM_symbolMap = {'`' : ['·'],'!' : ['！'],'$' : ['￥'],'^' : ['……'],'-' : [''],'_' : ['——'],'(' : ['（'],')' : ['）'],'[' : ['【'],']' : ['】'],'<' : ['《'],'>' : ['》'],'\' : ['、'],'/' : ['、'],';' : ['；'],':' : ['：'],',' : ['，'],'.' : ['。'],'?' : ['？'],"'" : ['‘', '’'],'"' : ['“', '”'],}
    ]])
end
function stop_zfvimim()
    if is_zf_load then
        vim.fn.ZFVimIME_stop()
    end
end

function toggle_zfvimim()
    is_zf_load = true
	vim.fn.ZFVimIME_keymap_toggle_i()
end

M.config = function()
	M.setLocalDB()
	vim.cmd([[
        autocmd User TelescopeFindPre lua stop_zfvimim()
    ]])
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
