return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", mode = { "n", "v" }, desc = "Stage hunk" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", mode = { "n", "v" }, desc = "Unstage hunk" },
      { "<leader>gx", "<cmd>Gitsigns reset_hunk<cr>", mode = { "n", "v" }, desc = "Reset hunk" },
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", mode = { "n", "v" }, desc = "Blame line" },
    },
    event = "VeryLazy",
    config = function()
      require("config._gitsigns").config()
    end,
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "NeogitOrg/neogit",
    },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<F3>", '<cmd>lua require("utils").toggleDiffView()<cr>', mode = "n" },
      { "<leader>gl", "<cmd>DiffviewFileHistory<cr>", mode = { "n", "v" }, desc = "Git log" },
      {
        "<leader>gc",
        "<cmd>DiffviewFileHistory %<cr>",
        mode = { "n", "v" },
        desc = "Current file git log",
      },
    },
    config = function()
      require("config._diffview").config()
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = true,
		cmd = { "G" },
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    keys = {
      -- { "<leader>gl", "<cmd>Neogit log<cr>", mode = { "n", "v" }, desc = "Git log" },
      -- { "<F3>", '<cmd>Neogit<cr>', mode = "n" },
    },
    -- setup = {
    --   vim.cmd([[ com! G lua require("neogit").open({ kind = "auto" })]]),
    -- },
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        log_view = {
          kind = "auto",
        },
        commit_editor = {
          kind = "split",
          show_staged_diff = false,
          staged_diff_split_kind = "split",
        },
        kind = "vsplit",
        auto_show_console = false,
        graph_style = "unicode",
        integrations = {
          diffview = true,
        },
        signs = {
          -- { CLOSED, OPENED }
          hunk = { "", "" },
          item = { "", "" },
          section = { "󰨙 ", "󰨚 " },
        },
        mappings = {
          status = {
            -- ["o"] = "Toggle",
            ["a"] = "Stage",
            ["="] = "Toggle",
          },
          popup = {
            ["P"] = "PullPopup",
            ["p"] = "PushPopup",
          },
        },
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    -- optional for floating window border decoration
    cmd = { "LazyGit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}