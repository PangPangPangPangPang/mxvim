local M = {}
M.default_open_status = false
M.bottom_open_status = 0
M.lazygit_open_status = false
M.open_term = function()
  M.default_open_status = not M.default_open_status
  vim.cmd([[ exe "FloatermToggle default" ]])
end
M.open_bottom_term = function()
  if M.bottom_open_status == 0 then
    M.bottom_open_status = 1
    vim.cmd([[ exe "FloatermNew --name=bottom --wintype=split --height=0.3" ]])
  elseif M.bottom_open_status == 1 then
    M.bottom_open_status = 2
    vim.cmd([[ exe "FloatermHide bottom" ]])
  else
    M.bottom_open_status = 1
    vim.cmd([[ exe "FloatermToggle bottom" ]])
  end
end
M.open_lazygit = function()
  M.lazygit_open_status = true
  vim.cmd([[ exe "FloatermNew --width=0.8 --height=0.8 lazygit" ]])
end

M.close = function()
  if M.default_open_status == true then
    M.default_open_status = false
    vim.cmd([[ exe "FloatermToggle default" ]])
  elseif M.lazygit_open_status == true then
    vim.cmd([[ exe "FloatermKill" ]])
    M.lazygit_open_status = false
    -- elseif M.bottom_open_status == 1 then
    -- 	M.bottom_open_status = 2
    -- 	vim.cmd([[ exe "FloatermHide bottom" ]])
  end
end
M.map = function()
  local g = vim.g
  local map = require("utils").map
  vim.api.nvim_command("hi! link FloatermBorder Directory")
  g.floaterm_title = "$1/$2"
  map("n", "<F5>", ":lua require('config._vim_floaterm').open_term()<CR>", { silent = true })
  map("t", "<F5>", "<C-\\><C-n>:lua require('config._vim_floaterm').open_term()<CR>", { silent = true })
  map("t", "<Esc>", "<C-\\><C-n>:lua require('config._vim_floaterm').close()<CR>", { silent = true })
  map("t", "<c-w>", "<C-\\><C-n><esc><c-w>", { silent = true })
  map("n", "<leader>lg", ":lua require('config._vim_floaterm').open_lazygit()<CR>", { silent = true })
  vim.cmd([[ autocmd FileType floaterm lua require('config._vim_floaterm').normal_map()]])
end

M.normal_map = function()
  vim.api.nvim_buf_set_keymap(
    0,
    "n",
    "<Esc>",
    "<C-\\><C-n>:lua require('config._vim_floaterm').close()<CR>",
    { silent = true }
  )
end

return M