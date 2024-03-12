local M = {}
M.config= function()
  require("smoothcursor").setup({
    cursor = "⏺︎ ",
    -- cursor = '▶ '
    -- cursor = "⫸ ",
    -- cursor = "㊡",
    disabled_filetypes = { "NeogitStatus", "NvimTree", "fzf" }, -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
    disable_float_win = true,
    always_redraw = false, -- Redraw the screen on each update
    speed = 100, -- Max speed is 100 to stick with your current position
    priority = 99, -- Set marker priority
  })
end
M.setup= function()
  local autocmd = vim.api.nvim_create_autocmd
  local colors = require("theme").colors()
  autocmd({ "ModeChanged" }, {
    callback = function()
      local current_mode = vim.fn.mode()
      if current_mode == "n" then
        vim.api.nvim_set_hl(0, "SmoothCursor", { fg = colors.blue })
      elseif current_mode == "v" then
        vim.api.nvim_set_hl(0, "SmoothCursor", { fg = colors.magenta })
      elseif current_mode == "V" then
        vim.api.nvim_set_hl(0, "SmoothCursor", { fg = colors.cyan })
      elseif current_mode == "�" then
        vim.api.nvim_set_hl(0, "SmoothCursor", { fg = colors.purple })
      elseif current_mode == "i" then
        vim.api.nvim_set_hl(0, "SmoothCursor", { fg = colors.green })
      end
    end,
  })
end
return M