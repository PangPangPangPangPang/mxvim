local M = {}
M.config = function()
  require("trouble").setup({
    auto_preview = true,
    auto_fold = true,
    keys = {
      o = "jump",
      ["<tab>"] = "jump",
      ["<cr>"] = "jump_close"
    },
  })
end
return M