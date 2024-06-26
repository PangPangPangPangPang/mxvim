local M = {}
M.config = function()
  local colors = require("theme").colors(0.8)
  vim.cmd(string.format(
    [[
        hi GitSignsAdd guifg=%s
        hi GitSignsChange guifg=%s
        hi GitSignsDelete guifg=%s
        hi GitSignsChangeDelete guifg=%s

			  hi! default link DiffAdd GitSignsAdd
			  hi! default link DiffChanged GitSignsChange
			  hi! default link DiffDelete GitSignsDelete
			  hi! default link DiffChangeDelete GitSignsChangeDelete
    ]],
    colors.green,
    colors.yellow,
    colors.red,
    colors.purple
  ))
  require("gitsigns").setup({
    signs = {
      -- add          = { text = '▋' },
      -- change       = { text = '▋' },
      -- delete       = { text = '契' },
      -- topdelete    = { text = '▔' },
      -- changedelete = { text = '▌' },
      -- untracked    = { text = '▒' },
      -- add          = { text = '▌' },
      -- change       = { text = '▌' },
      -- delete       = { text = '▌' },
      -- topdelete    = { text = '▔' },
      -- changedelete = { text = '▌' },
      -- untracked    = { text = '▌' },
      add = { text = "▐" },
      change = { text = "▐" },
      delete = { text = "▐" },
      topdelete = { text = "▔" },
      changedelete = { text = "▐" },
      untracked = { text = "▐" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  })
end
return M