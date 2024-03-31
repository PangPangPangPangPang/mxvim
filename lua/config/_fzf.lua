local M = {}
M.config = function()
  local actions = require("fzf-lua.actions")
  require("fzf-lua").setup({
    "default",
    fzf_colors = {
      ["fg"] = { "fg", "CursorLine" },
      ["bg"] = { "bg", "Normal" },
      ["hl"] = { "fg", "Redfg" },
      ["fg+"] = { "fg", "Blackfg" },
      ["bg+"] = { "bg", "Greenbg" },
      ["hl+"] = { "fg", "Redfg" },
      ["info"] = { "fg", "PreProc" },
      ["prompt"] = { "fg", "Conditional" },
      ["pointer"] = { "fg", "Execption" },
      ["marker"] = { "fg", "Keyword" },
      ["spinner"] = { "fg", "Float" },
      ["header"] = { "fg", "Comment" },
      ["gutter"] = { "bg", "Normal" },
    },
    actions = {
      files = {
        ["enter"] = actions.file_edit,
        ["ctrl-s"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
        ["alt-q"] = actions.file_sel_to_qf,
        ["alt-l"] = actions.file_sel_to_ll,
      },
    },
    files = {
      prompt = "   ",
      file_icons = true,
      cwd_prompt = false,
      fzf_opts = {
        ["--info"] = "inline", -- inline / default
        ["--no-scrollbar"] = "",
        -- ['--extended'] = "",
      },
      actions = { ["ctrl-g"] = false },
    },
    winopts = {
      border = "rounded",
      preview = {
        layout = "vertical",
        border = "noborder",
      },
    },
  })
  vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "Directory" })
  vim.api.nvim_set_hl(0, "FzfLuaTitle", { link = "Float" })
  vim.api.nvim_set_hl(0, "FzfLuaCursor", { link = "Float" })
  vim.api.nvim_set_hl(0, "FzfLuaCursorLine", { link = "Float" })
  vim.api.nvim_set_hl(0, "FzfLuaCursorLineNr", { link = "Float" })


	-- map fzf-lua to default if fzf called once
	local dmap = require("utils").dmap
	dmap({ "i", "n" }, "<c-p>", '<cmd>lua require("fzf-lua").files()<cr>')
end

M.hl_fzf = function()
  vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "Directory" })
  vim.api.nvim_set_hl(0, "FzfLuaTitle", { link = "Float" })
end
return M