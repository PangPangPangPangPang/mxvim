return {
  {
    "kyazdani42/nvim-tree.lua",
    enabled = not mxvim.enable_neotree,
    lazy = true,
    event = "VeryLazy",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    init = function()
      require("config._tree").init()
    end,
    keys = {
      { "<F1>", "<cmd>NvimTreeToggle<cr>", mode = { "n" }, desc = "Jump to file tree" },
      { "<leader>j", "<cmd>NvimTreeFindFile<cr>", mode = { "n" }, desc = "Jump to file tree" },
    },
    config = function()
      require("config._tree").config()
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = true,
    cmd = { "Oil" },
    opts = {},
    init = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
          ["<C-v>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
          ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
          ["<C-o>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["<C-h>"] = "actions.parent",
          ["<C-p>"] = false,
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = mxvim.enable_neotree,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree" },
    keys = {
      { "<F1>", "<cmd>Neotree filesystem toggle<cr>", mode = "n" },
      { "<leader>j", "<cmd>Neotree reveal<cr>", mode = { "n" } },
    },
    config = function()
      require("config._neotree").config()
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      mxvim.enable_neotree and "nvim-neo-tree/neo-tree.nvim" or "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}
