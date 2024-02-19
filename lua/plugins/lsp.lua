return {
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "nvim-lua/lsp-status.nvim" },
      { "hrsh7th/nvim-cmp" },
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require("config._mason").config()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function()
      require("config._lsp_config").config()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    dependencies = {
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      {
        "hrsh7th/cmp-vsnip",
        dependencies = {
          "hrsh7th/vim-vsnip-integ",
          "hrsh7th/vim-vsnip",
          "rafamadriz/friendly-snippets",
        },
      },
      {
        "quangnguyen30192/cmp-nvim-tags",
      },
    },
    config = function()
      require("config._nvim_cmp").config()
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    lazy = true,
    enabled = mxvim.enable_lspsage,
    event = "VeryLazy",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
      require("config._lsp_saga").config()
    end,
  },
  {
    "folke/lsp-trouble.nvim",
    lazy = true,
    cmd = { "LspTrouble", "Trouble" },
    config = function()
      require("config._lsp_trouble").config()
    end,
  },
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<F2>", "<cmd>AerialToggle<cr>", { "n", "i" } },
    },
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- require("lsp.lsp_ts"),
  {
    "jay-babu/mason-null-ls.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("lsp.lsp_nullls").config()
    end,
  },
  {
    "wojciech-kulik/xcodebuild.nvim",
    enabled = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("xcodebuild").setup({
        -- put some options here or leave it empty to use default settings
      })
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions, { desc = "Code action" })
      require("actions-preview").setup({
        telescope = vim.tbl_extend(
          "force",
          require("telescope.themes").get_cursor({
            layout_config = {
              width = 0.5,
            },
          }),
          {
            make_value = nil,
            make_make_display = nil,
          }
        ),
      })
    end,
  },
}