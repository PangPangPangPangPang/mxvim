local M = {}
M.setup = function()
  local g = vim.g
  g.indent_blankline_use_treesitter = false
  g.indent_blankline_context_patterns = {
    "declaration",
    "expression",
    "pattern",
    "primary_expression",
    "statement",
    "switch_body",
  }
end
M.setupIndent = function(opts)
  local colors = require("theme").colors(0.3)

  local hooks = require("ibl.hooks")
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors.red })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors.yellow })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors.blue })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colors.orange })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors.green })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = colors.purple })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colors.cyan })
  end)
  -- hooks.register(hooks.type.VIRTUAL_TEXT, function(_, _, _, virt_text)
  --   if virt_text[1] and virt_text[1][1] == opts.indent.char then
  --     virt_text[1] = { " ", { "@ibl.whitespace.char.1" } }
  --   end
  --   return virt_text
  -- end)
  require("ibl").setup(opts)

end

return M