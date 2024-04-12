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
		texthl = "Greenfg",
  })
end
return M