local cmd = vim.cmd
local M = {}

function M.opt(o, v, scopes)
	scopes = scopes or { vim.o }
	v = v == nil and true or v

	if type(v) == "table" then
		v = table.concat(v, ",")
	end

	for _, s in ipairs(scopes) do
		s[o] = v
	end
end

function M.map(modes, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap == nil and true or opts.noremap
	if type(modes) == "string" then
		modes = { modes }
	end
	for _, mode in ipairs(modes) do
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

function M.dmap(modes, lhs, rhs, desc)
	local opts = { noremap = true, silent = true, desc = desc }
	M.map(modes, lhs, rhs, opts)
end

function M.create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		cmd("augroup " .. group_name)
		cmd("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			cmd(command)
		end
		cmd("augroup END")
	end
end

function M.close_common()
	local list = { "qf", "fugitive", "git", "Trouble", "noice", "fugitiveblame", "NeogitStatus" }

	-- go back to prev window
	local cur = vim.fn.winnr()
	local current_filetype = vim.fn.getwinvar(cur, "&filetype")
	for _, value in pairs(list) do
		if value == current_filetype then
			local pre = vim.fn.winnr("#")
			if pre ~= -1 then
				vim.cmd([[ exe "wincmd p" ]])
			end
			break
		end
	end

	local t = vim.fn.getbufinfo()
	for _, i in pairs(t) do
		for _, type in ipairs(list) do
			local filetype = vim.fn.getbufvar(i.bufnr, "&filetype")
			if type == filetype then
				for _, wid in ipairs(i.windows) do
					vim.cmd(string.format('exe %d . "wincmd c"', vim.fn.win_id2win(wid)))
				end
			end
		end
	end
end

function M.toggleDiffView()
	local t = vim.fn.getbufinfo()
	for _, i in pairs(t) do
		local filetype = vim.fn.getbufvar(i.bufnr, "&filetype")
		if "DiffviewFiles" == filetype then
			vim.cmd([[ DiffviewClose ]])
			return
		end
	end
	vim.cmd [[ DiffviewOpen ]]
end

M.dump = function(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

M.is_module_available = function(name)
	if package.loaded[name] then
		return true
	else
		for _, searcher in ipairs(package.searchers or package.loaders) do
			local loader = searcher(name)
			if type(loader) == "function" then
				package.preload[name] = loader
				return true
			end
		end
		return false
	end
end

M.hook_print = function()
	_G.original_print = _G.print
	_G.print = require("utils").print
end

M.print = function(msg)
	if msg == nil then
		return
	end
	local mess = msg
	if type(msg) == "table" then
		mess = vim.fn.json_encode(vim.inspect(msg))
	elseif type(msg) == "number" then
		mess = string.format("%d", msg)
	elseif type(msg) == "userdata" then
		mess = vim.fn.json_encode(vim.inspect(getmetatable(msg)))
	end
	if mxvim.use_notify == false then
		_G.original_print(mess)
		return
	end
	M.safe_require("notify", function(notify)
		notify(mess)
	end, function()
		_G.original_print(mess)
	end)
end

M.safe_require = function(name, func, err)
	local present, plug = pcall(require, name)
	if present and func ~= nil then
		func(plug)
	elseif err ~= nil then
		err()
	end
end

M.systemName = nil
M.system = function()
	if M.systemName ~= nil then
		return M.systemName
	end
	if vim.fn.has("macunix") == 1 then
		M.systemName = "MacOS"
	elseif vim.fn.has("win32") == 1 then
		M.systemName = "Windows"
	elseif vim.fn.has("unix") == 1 then
		M.systemName = "Linux"
	end
	return M.systemName
end

M.shallow_copy = function(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

M.Set = function(list)
	local set = {}
	for _, l in ipairs(list) do
		set[l] = true
	end
	return set
end

M.load_plugins = function()
	local fn = vim.fn
	local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	vim.cmd([[ com! PS lua require('lazy').sync() ]])
	require("lazy").setup("plugins")
end

M.is_alacritty = function ()
	return os.getenv("TERM") == "alacritty"
end

return M