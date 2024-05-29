local M = {}
M.setup = function(opts)
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

M.setup_hlchunk = function()
  local ft = require("cool-chunk.utils.filetype").support_filetypes
  require("cool-chunk").setup({
    chunk = {
      notify = true,
      support_filetypes = ft.support_filetypes, -- ft = require("cool-chunk.utils.filetype").support_filetypes
      exclude_filetypes = ft.exclude_filetypes,
      hl_group = {
        chunk = "Yellowfg",
        error = "Error",
      },
      chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        left_arrow = "<",
        bottom_arrow = "v",
        right_arrow = ">",
      },
      textobject = "ah",
      animate_duration = 100,
      fire_event = { "CursorHold", "CursorHoldI" },
    },
    context = {
      enable = false,
      notify = true,
      chars = {
        "│",
      },
      hl_group = {
        context = "LineNr",
      },
      exclude_filetypes = ft.exclude_filetypes,
      support_filetypes = ft.support_filetypes,
      textobject = "ih",
      jump_support_filetypes = { "lua", "python" },
      jump_start = "[{",
      jump_end = "]}",
      fire_event = { "CursorHold", "CursorHoldI" },
    },
    line_num = {
      notify = true,
      hl_group = {
        chunk = "CursorLineNr",
        context = "LineNr",
        error = "Error",
      },
      support_filetypes = ft.support_filetypes,
      exclude_filetypes = ft.exclude_filetypes,
      fire_event = { "CursorHold", "CursorHoldI" },
    },
  })
end

return M