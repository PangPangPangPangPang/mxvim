return {
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermToggle", "FloatermNew" },
    keys = {
      { "<F5>", "<cmd>lua require('config._vim_floaterm').open_term()<cr>", mode = "n" },
      { "<F5>", "<C-\\><C-n>:lua require('config._vim_floaterm').open_term()<CR>", mode = "t" },
      { "<Esc>", "<C-\\><C-n>:lua require('config._vim_floaterm').close()<CR>", mode = "t" },
      { "<leader>lg", ":lua require('config._vim_floaterm').open_lazygit()<CR>", mode = "n" },
    },
    config = function()
      require("config._vim_floaterm").map()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    enabled = not vim.g.neovide,
    event = "VeryLazy",
    config = function()
      require("config._neoscroll").config()
    end,
  },
  {
    "0x00-ketsu/maximizer.nvim",
    keys = {
      { "<c-w>z", "<cmd>lua require('maximizer').toggle()<CR>", mode = "n" },
    },
    config = function()
      require("maximizer").setup({})
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "skywind3000/vim-quickui",
    event = "VeryLazy",
    init = function()
      vim.g.quickui_border_style = 2
      vim.g.quickui_color_scheme = "system"
    end,
  },
  {
    -- "~/bilibili_live_broadcast",
    "PangPangPangPangPang/bilibili_live_broadcast",
    enabled = false,
    lazy = true,
    cmd = { "BiliLive" },
    config = function()
      require("config._bili_live").config()
    end,
    dependencies = { "rcarriga/nvim-notify" },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { preset = "helix" },
    config = function()
      local wk = require("which-key")
      wk.setup({
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        win = {
          width = 0.5,
          border = "single", -- none, single, double, shadow
          padding = { 1, 2 },
          zindex = 1000, -- positive value to position WhichKey above other floating windows.
          wo = {
            winblend = 100,
          },
        },
        layout = {
          align = "right",
        },
        show_help = false, -- show a help message in the command line for using WhichKey
        show_keys = false, -- show the currently pressed key and its label as a message in the command line
      })
      wk.add({
        { "<leader>g", group = "Git" },
        { "<leader>gA", desc = "Diff Choose all" },
        { "<leader>gB", desc = "Diff Choose base" },
        { "<leader>gX", desc = "Diff Choose none" },
        { "<leader>go", desc = "Diff Choose ours" },
        { "<leader>gt", desc = "Diff Choose theirs" },
      })
      wk.add({
        { "<leader>w", group = "Workspace" },
        { "<leader>wa", desc = "Add workspace folder" },
      })
      wk.add({
        { "<leader>l", group = "Diagnostic" },
      })
      wk.add({
        { "<leader>=", group = "Format" },
      })
      wk.add({
        { "<leader>c", group = "Language Server" },
        { "<leader>ca", desc = "Code action" },
      })
      wk.add({
        { "<leader><Down>", group = "Change" },
        { "<leader><Up>", group = "Change" },
      })
    end,
  },
  {
    "github/copilot.vim",
    enabled = false,
    config = function()
      vim.cmd([[
		imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
		let g:copilot_no_tab_map = v:true
			]])
    end,
  },
  {
    "p5quared/apple-music.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = true,
    keys = {
      {
        "<leader>mm",
        function()
          require("apple-music").toggle_play()
        end,
        desc = "Toggle playback[M]",
      },
      {
        "<leader>ms",
        function()
          require("apple-music").toggle_shuffle()
        end,
        desc = "Toggle [S]huffle",
      },
      {
        "<leader>mp",
        function()
          require("apple-music").select_playlist_telescope()
        end,
        desc = "Find [P]laylists",
      },
      {
        "<leader>ma",
        function()
          require("apple-music").select_album_telescope()
        end,
        desc = "Find [A]lbum",
      },
      {
        "<leader>mS",
        function()
          require("apple-music").select_track_telescope()
        end,
        desc = "Find [S]ong",
      },
      {
        "<leader>mx",
        function()
          require("apple-music").cleanup_all()
        end,
        desc = "Cleanup Temp Playlists",
      },
    },
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvzone/timerly",
    cmd = "TimerlyToggle",
    dependencies = {
      "nvzone/volt",
    },
  },
  {
    "Goose97/timber.nvim",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      local function patch_timber_for_nvim_012()
        vim.treesitter.query.add_directive("make-logable-range!", function(match, _, _, predicate, metadata)
          local capture_id = predicate[2]
          local range_type = predicate[3]
          local node = match[capture_id]

          if vim.fn.has("nvim-0.11") == 1 and type(node) == "table" then
            node = node[1]
          end

          if not node or type(node.range) ~= "function" then
            return
          end

          local start_adjust = tonumber(predicate[4]) or 0
          local end_adjust = tonumber(predicate[5]) or 0
          local start_row, _, end_row, _ = node:range()

          local adjusted_start_row = math.max(0, start_row + start_adjust)
          local adjusted_end_row = math.max(adjusted_start_row, end_row + 1 + end_adjust)

          local logable_ranges = metadata.logable_ranges or {}
          if range_type == "outer" then
            table.insert(logable_ranges, { 0, adjusted_start_row })
            table.insert(logable_ranges, { adjusted_end_row, math.huge })
          elseif range_type == "inner" then
            table.insert(logable_ranges, { adjusted_start_row, adjusted_end_row })
          elseif range_type == "before" then
            table.insert(logable_ranges, { 0, adjusted_start_row })
          elseif range_type == "after" then
            table.insert(logable_ranges, { adjusted_end_row, math.huge })
          end

          metadata.logable_ranges = logable_ranges
        end, { force = true })
      end

      require("timber").setup({
        -- Configuration here, or leave empty to use defaults
        keymaps = {
          -- Set to false to disable the default keymap for specific actions
          -- insert_log_below = false,
          insert_log_below = "<leader>ll",
          insert_log_above = "glk",
          insert_plain_log_below = "glo",
          insert_plain_log_above = "gl<S-o>",
          insert_batch_log = "glb",
          add_log_targets_to_batch = "gla",
          insert_log_below_operator = "g<S-l>j",
          insert_log_above_operator = "g<S-l>k",
          insert_batch_log_operator = "g<S-l>b",
          add_log_targets_to_batch_operator = "g<S-l>a",
        },
        log_marker = "🪵", -- Or any other string, e.g: MY_LOG
      })
      patch_timber_for_nvim_012()
      vim.keymap.set("n", "<leader>lc", function()
        require("timber.actions").clear_log_statements({ global = false })
      end)
    end,
  },
  {
    "alex-popov-tech/store.nvim",
    dependencies = {
      "OXY2DEV/markview.nvim", -- optional, for pretty readme preview / help window
    },
    cmd = "Store",
    opts = {
      -- optional configuration here
    },
  },
}
