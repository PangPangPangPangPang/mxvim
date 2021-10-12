local cmd = vim.cmd
local M = {}

function M.opt(o, v, scopes)
    scopes = scopes or {vim.o}
    v = v == nil and true or v

    if type(v) == 'table' then v = table.concat(v, ',') end

    for _, s in ipairs(scopes) do s[o] = v end
end

function M.map(modes, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    if type(modes) == 'string' then modes = {modes} end
    for _, mode in ipairs(modes) do
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
end

function M.dmap(modes, lhs, rhs)
    local opts = {noremap = true, silent = true}
    M.map(modes, lhs, rhs, opts)
end

function M.create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        cmd('augroup ' .. group_name)
        cmd('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            cmd(command)
        end
        cmd('augroup END')
    end
end

function M.close_common()
    local list = {'qf', 'fugitive', 'git', 'Trouble'}

    -- go back to prev window
    local cur = vim.fn.winnr()
    local current_filetype = vim.fn.getwinvar(cur, '&filetype')
    for _, value in pairs(list) do
        if value == current_filetype then
            local pre = vim.fn.winnr('#')
            if pre ~= -1 then
                vim.cmd([[ exe "wincmd p" ]])
            end
            break;
        end
    end

    local t = vim.fn.getbufinfo()
    for _, i in pairs(t) do
        for _, type in ipairs(list) do
            local filetype = vim.fn.getbufvar(i.bufnr, '&filetype')
            if type == filetype then
                for _, wid in ipairs(i.windows) do
                    vim.cmd(string.format("exe %d . \"wincmd c\"",
                                          vim.fn.win_id2win(wid)))
                end
            end
        end
    end
end

M.dump = function(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. M.dump(v) .. ','
      end
      return s .. '} '
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
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

M.print = function (msg)
    require('notify')(msg)
end

M.safe_require = function(name, func)
    local present, plug = pcall(require, name)
    if present then
        func(plug)
    end
end

M.systemName = nil
M.system = function ()
    if M.systemName ~= nil then
       return M.systemName;
    end
    if vim.fn.has('macunix') == 1 then
        M.systemName = "MacOS"
    elseif vim.fn.has('win32') == 1 then
        M.systemName = "Windows"
    elseif vim.fn.has('unix') == 1 then
        M.systemName = "Linux"
    end
    return M.systemName
end

M.shallow_copy = function(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
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
  for _, l in ipairs(list) do set[l] = true end
  return set
end

return M
