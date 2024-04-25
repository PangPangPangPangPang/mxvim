local M = {}
M.config = function()
  local files = {
    prompt = "   ",
    file_icons = true,
    cwd_prompt = false,
    fzf_opts = {
      ["--info"] = "default", -- inline / default
      ["--no-scrollbar"] = "",
      -- ['--extended'] = "",
    },
    actions = { ["ctrl-g"] = false },
    ignore_current_file = true,
  }
  if vim.fn.executable("fd") == 1 then
    local fzfutils = require("fzf-lua.utils")
    files.cmd = string.format(
      [[fd --color=never --type f --hidden --follow --exclude .git -x printf "{}: {/} %s\n"]],
      fzfutils.ansi_codes.grey("{//}")
    )
    files.fzf_opts = {
      -- process ansi colors
      ["--ansi"] = "",
      ["--with-nth"] = "2..",
      ["--delimiter"] = "\\s",
      ["--tiebreak"] = "begin,index",
      ["--info"] = "default", -- inline / default
      ["--no-scrollbar"] = "",
    }
  end
  local actions = require("fzf-lua.actions")
  local shade_colors = require("theme").colors(0.1)
  local colors = require("theme").colors()
  require("fzf-lua").setup({
    "default",
    fzf_colors = {
      ["fg"] = { "fg", "CursorLine" },
      ["bg"] = shade_colors.green,
      ["hl"] = { "fg", "Redfg" },
      ["fg+"] = { "fg", "Blackfg" },
      ["bg+"] = { "bg", "Greenbg" },
      ["hl+"] = { "fg", "Redfg" },
      ["info"] = { "fg", "PreProc" },
      ["prompt"] = shade_colors.blue,
      ["pointer"] = { "fg", "Execption" },
      ["marker"] = { "fg", "Keyword" },
      ["spinner"] = { "fg", "Float" },
      ["header"] = { "fg", "Comment" },
      ["gutter"] = shade_colors.green,
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
    files = files,
    winopts = {
      -- border = "none",
      border = { " ", " ", " ", " ", " ", " ", " ", " " },
      preview = {
        layout = "vertical",
        border = "noborder",
      },
    },
  })
  vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = shade_colors.red })
  vim.api.nvim_set_hl(0, "FzfLuaTitle", { link = "Float" })
  vim.api.nvim_set_hl(0, "FzfLuaPreviewTitle", { fg = colors.red, bg = shade_colors.red })
  vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { bg = shade_colors.red })
  vim.api.nvim_set_hl(0, "FzfLuaBorder", { bg = shade_colors.green, fg = "red" })
  vim.api.nvim_set_hl(0, "FloatBorderTerm", { bg = shade_colors.green, fg = "red" })
  vim.api.nvim_set_hl(0, "FzfLuaBufName", { bg = shade_colors.green, fg = "red" })
  vim.api.nvim_set_hl(0, "FzfLuaCursor", { link = "Float" })
  vim.api.nvim_set_hl(0, "FzfLuaCursorLine", { link = "Float" })
  vim.api.nvim_set_hl(0, "FzfLuaCursorLineNr", { link = "Float" })

  -- map fzf-lua to default if fzf called once
  local dmap = require("utils").dmap
  dmap({ "i", "n" }, "<c-p>", '<cmd>lua require("fzf-lua").files()<cr>')
end

M.hl_fzf = function()
  local shade_colors = require("theme").colors(0.1)
  vim.api.nvim_set_hl(0, "FzfLuaBorder", { bg = shade_colors.green, fg = "red" })
  vim.api.nvim_set_hl(0, "FzfLuaTitle", { link = "Float" })
end
return M