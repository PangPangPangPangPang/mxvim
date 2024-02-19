return {
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermToggle", "FloatermNew" },
    keys = {
      { "<F5>", "<cmd>lua require('config._vim_floaterm').open_term()<cr>", mode = "n" },
      { "<F5>", "<C-\\><C-n>:lua require('config._vim_floaterm').open_term()<CR>", mode = "t" },
      { "<F6>", "<cmd>lua require('config._vim_floaterm').open_bottom_term()<cr>", mode = "n" },
      { "<F6>", "<C-\\><C-n>:lua require('config._vim_floaterm').open_bottom_term()<CR>", mode = "t" },
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
    lazy = true,
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
  { "tpope/vim-dadbod", cmd = { "DB" } },
  {
    "skywind3000/vim-quickui",
    lazy = true,
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
    "jackMort/ChatGPT.nvim",
    lazy = true,
    cmd = { "ChatGPT" },
    config = function()
      require("chatgpt").setup({
        keymaps = {
          close = { "<C-c>" },
          submit = "<C-e>",
          yank_last = "<C-y>",
          yank_last_code = "<C-k>",
          scroll_up = "<C-u>",
          scroll_down = "<C-d>",
          toggle_settings = "<C-o>",
          new_session = "<C-n>",
          cycle_windows = "<Tab>",
          -- in the Sessions pane
          select_session = "<Space>",
          rename_session = "r",
          delete_session = "d",
        },

        -- optional configuration
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        window = {
          border = "single", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0.5 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
          padding = { 1, 2, 0, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
          zindex = 1000, -- positive value to position WhichKey above other floating windows.
        },
        show_help = false, -- show a help message in the command line for using WhichKey
        show_keys = false, -- show the currently pressed key and its label as a message in the command line
      })
      wk.register({
        g = {
          name = "Git",
        },
      }, { prefix = "<leader>" })
      wk.register({
        w = {
          name = "Workspace",
          a = "Add workspace folder",
        },
      }, { prefix = "<leader>" })
      wk.register({
        l = {
          name = "Diagnostic",
        },
      }, { prefix = "<leader>" })
      wk.register({
        ["="] = {
          name = "Format",
        },
      }, { prefix = "<leader>" })
      wk.register({
        c = {
          name = "Language Server",
          a = "Code action",
        },
      }, { prefix = "<leader>" })
      wk.register({
        ["<Down>"] = {
          name = "Change",
        },
        ["<Up>"] = {
          name = "Change",
        },
      }, { prefix = "<leader>" })
      wk.register({
        d = {
          name = "Git Diff",
          o = "Choose ours",
          t = "Choose theirs",
          b = "Choose base",
          a = "Choose all",
        },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "skywind3000/vim-gpt-commit",
    cmd = { "GptCommit" },
    config = function()
      vim.g.gpt_commit_key = os.getenv("OPENAI_API_KEY")
    end,
  },
}