local M = {}
M.config = function()
  local keymap = vim.keymap.set
  local saga = require("lspsaga")
  local colors = require("theme").colors()

  saga.setup({
    move_in_saga = { prev = "<C-p>", next = "<C-n>" },
    finder_action_keys = {
      open = "<CR>",
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = "<esc>",
      scroll_down = "<S-down>",
      scroll_up = "<S-up>",
    },
    lightbulb = {
      enable = false,
      sign = true,
      enable_in_insert = true,
      sign_priority = 20,
      virtual_text = true,
    },
    diagnostic = {
      show_code_action = true,
      show_source = true,
      jump_num_shortcut = true,
      --1 is max
      max_width = 0.7,
      custom_fix = nil,
      custom_msg = nil,
      text_hl_follow = true,
      border_follow = true,
      keys = {
        exec_action = "o",
        quit = { "q", "<ESC>" },
        go_action = "g",
      },
    },
    rename = {
      keys = {
        quit = "<esc>",
      },
    },
    symbol_in_winbar = {
      -- enable = vim.fn.has("nvim-0.8") == 1,
      enable = false,
      separator = "  ",
      hide_keyword = true,
      show_file = true,
      folder_level = 2,
    },
    code_action = {
      show_server_name = true,
      extend_gitsigns = false,
      keys = {
        quit = "<esc>",
        prev = "<C-p>",
        next = "<C-n>",
      },
    },
    ui = {
      title = false,
      -- Border type can be single, double, rounded, solid, shadow.
      border = "rounded",
      devicon = true,
      winblend = 0,
      expand = "",
      collapse = "",
      code_action = " ",
      incoming = " ",
      outgoing = " ",
      hover = " ",
      colors = {
        --float window normal background color
        normal_bg = "none",
        --title background color
        title_bg = colors.green,
        red = colors.red,
        magenta = colors.magenta,
        orange = colors.orange,
        yellow = colors.yellow,
        green = colors.green,
        cyan = colors.cyan,
        blue = colors.blue,
        purple = colors.purple,
        white = colors.fg,
        black = colors.bg,
      },
      kind = {},
    },
  })

  -- Lsp finder find the symbol definition implmement reference
  -- keymap("n", "<c-]>", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

  -- Code action
  keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
  keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })

  -- Rename
  keymap("n", "<space>cn", "<cmd>Lspsaga rename<CR>", { silent = true })

  -- Definition preview
  keymap("n", "gh", "<cmd>Lspsaga preview_definition<CR>", { silent = true })

  -- Show line diagnostics
  -- keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

  -- Show cursor diagnostic
  keymap("n", "J", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

  -- Diagnsotic jump
  keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
  keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })

  -- Only jump to error
  keymap("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, {
    silent = true,
  })
  keymap("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, {
    silent = true,
  })

  -- Outlne
  keymap("n", "<F2>", "<cmd>Lspsaga outline<CR>", { silent = true })

  -- Hover Doc
  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

  -- Signature help
  keymap("n", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", { silent = true })

  vim.cmd([[
		augroup ClearMappings
			autocmd!
			autocmd FileType saga_codeaction noremap <buffer> <c-p> <up>
		augroup END
	]])
end

return M