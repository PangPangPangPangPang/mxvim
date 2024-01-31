return {
  -- commenter
  {
    "tpope/vim-commentary",
    enabled = not mxvim.enable_treesitter,
    config = function()
      vim.g.kommentary_create_default_mappings = false
      vim.api.nvim_set_keymap("n", "<leader>/", "gcc", { desc = "Comment" })
      vim.api.nvim_set_keymap("v", "<leader>/", "gc", { desc = "Comment" })
    end,
  },
  {
    "numToStr/Comment.nvim",
    enabled = mxvim.enable_treesitter,
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
    lazy = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- fold
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    lazy = true,
    event = "VeryLazy",
    init = function()
      vim.o.foldcolumn = "1"
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
}