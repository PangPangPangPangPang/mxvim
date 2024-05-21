return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = mxvim.enable_treesitter,
    event = "VeryLazy",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/playground",
      "HiPhish/rainbow-delimiters.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup({
            opts = {
              -- Defaults
              enable_close = true, -- Auto close tags
              enable_rename = true, -- Auto rename pairs of tags
              enable_close_on_slash = true, -- Auto close on trailing </
            },
          })
        end,
      },
      "lukas-reineke/indent-blankline.nvim",
      "numToStr/Comment.nvim",
      -- "m-demare/hlargs.nvim",
    },
    build = ":TSUpdate",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
      require("config._treesitter")
    end,
  },
}