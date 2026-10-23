return {
  -- commenter
  {
    "tpope/vim-commentary",
    enabled = not mxvim.enable_treesitter,
    event = "VeryLazy",
    dependencies = {
      "lukas-reineke/indent-blankline.nvim",
    },
    config = function()
      vim.g.kommentary_create_default_mappings = false
      vim.api.nvim_set_keymap("n", "<leader>/", "gcc", { desc = "Comment" })
      vim.api.nvim_set_keymap("v", "<leader>/", "gc", { desc = "Comment" })
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = false,
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>/", "gcc", { desc = "Comment" })
      vim.api.nvim_set_keymap("v", "<leader>/", "gc", { desc = "Comment" })
    end,
  },
  {
    "numToStr/Comment.nvim",
    enabled = mxvim.enable_treesitter,
    lazy = true,
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        toggler = {
          ---Line-comment toggle keymap
          line = "<leader>/",
          ---Block-comment toggle keymap
          block = "gbc",
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = "<leader>/",
          ---Block-comment keymap
          block = "gb",
        },
      })
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- fold
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    init = function()
      if mxvim.show_fold then
        vim.o.foldcolumn = "1"
      end
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = require("config._other").ufo_opts,
    config = function(_, opts)
      require("config._other").ufo_config(opts)
    end,
  },
  -- input method
  {
    "ybian/smartim",
    lazy = true,
    -- event = { "InsertEnter" },
    config = function()
      -- default IME mode
      vim.g.smartim_default = "com.apple.keylayout.ABC"
    end,
  },
  {
    "saghen/blink.pairs",
    dependencies = "saghen/blink.lib",
    version = "*",
    build = function()
      require("blink.pairs").download():pwait(60000)
    end,
    event = "InsertEnter",

    opts = {
      mappings = {
        enabled = true,
        disabled_filetypes = {},
        pairs = {},
      },
      highlights = {
        enabled = true,
        groups = {
          "Redfg",
          "Yellowfg",
          "Orangefg",
          "Greenfg",
        },
        matchparen = {
          enabled = true,
          group = "BlinkPairsMatchParen",
        },
      },
      debug = false,
    },
  },
  { "tpope/vim-surround" },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      continue = false,
      modes = {
        search = {
          enabled = false,
        },
        char = {
          multi_line = true,
          jump_labels = false,
          keys = { "f", "F", "t", "T", ";", "," },
          highlight = { backdrop = false },
        },
      },
    },
    keys = {
      {
        "cl",
        mode = { "n", "x", "o" },
        function()
          require("config._flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "justinmk/vim-sneak",
    enabled = false,
    lazy = true,
    config = function()
      require("config._sneak").config()
    end,
  },
  {
    "kshenoy/vim-signature",
    enabled = false,
    lazy = true,
  },
  {
    "blackhat-7/vellum.nvim",
    ft = "markdown",
    keys = { { "<leader>mp", "<cmd>Vellum<cr>", desc = "Markdown preview" } },
    opts = {},
  },
  -- install without yarn or npm
  {
    "mattn/emmet-vim",
    ft = { "css", "javascriptreact", "html", "typescriptreact" },
    init = function()
      vim.g.user_emmet_expandabbr_key = "<C-y><tab>"
      vim.g.user_emmet_prev_key = "<C-y>p"
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    cmd = { "Refactor" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    init = function()
      vim.keymap.set("x", "<leader>re", ":Refactor extract ")
      vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

      vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

      vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

      vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")

      vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
      vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
    end,
    config = function()
      require("refactoring").setup()
    end,
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    config = true,
    keys = { "v", "V", "<C-v>" },
  },
}
