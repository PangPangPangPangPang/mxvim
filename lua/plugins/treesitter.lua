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
      "windwp/nvim-ts-autotag",
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
      -- require("config._treesitter").inithlargs()
    end,
  },
}