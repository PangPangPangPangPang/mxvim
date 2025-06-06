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
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
      require("config._autopairs").setup()
    end,
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
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    opts = {
      sign = {
        enabled = false,
      },
      bullet = { right_pad = 2 },
    },
  },
  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- html
  {
    "mattn/emmet-vim",
    ft = { "css", "javascriptreact", "html", "typescriptreact" },
    init = function()
      vim.g.user_emmet_expandabbr_key = "<C-y><tab>"
      vim.g.user_emmet_prev_key = "<C-y>p"
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },
    },
    config = function()
      vim.o.conceallevel = 1
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
