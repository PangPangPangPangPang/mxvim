local M = {}
M.config = function()
  local files = {
    prompt = "   ",
    file_icons = true,
    cwd_prompt = false,
    fzf_opts = {
      ["--info"] = "inline-right", -- inline / default
      ["--no-scrollbar"] = "",
      ["--extended"] = "",
      ["--no-separator"] = "",
      ["--pointer"] = "▶ ",
      ["--header"] = " ",
    },
    actions = { ["ctrl-g"] = false },
    ignore_current_file = true,
    -- path_shorten = 1,
    formatter = "path.filename_first",
  }
  local actions = require("fzf-lua.actions")
  require("fzf-lua").setup({
    "borderless",
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
  local dmap = require("utils").dmap
  dmap({ "i", "n" }, "<c-p>", '<cmd>lua require("fzf-lua").files()<cr>')
end

return M