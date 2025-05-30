return {
  {
    "mhinz/vim-grepper",
    event = "VeryLazy",
    init = function()
      require("config._grep").setup()
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      -- { "<leader>p", "<cmd>lua require('fzf-lua').files()<cr>" },
      { "<c-p>", "<cmd>lua require('fzf-lua').files()<cr>" },
    },
    config = function()
      require("config._fzf").config()
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    init = function()
      local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
      vim.api.nvim_create_autocmd("User", {
        pattern = "NvimTreeSetup",
        callback = function()
          local events = require("nvim-tree.api").events
          events.subscribe(events.Event.NodeRenamed, function(data)
            if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
              data = data
              Snacks.rename.on_rename_file(data.old_name, data.new_name)
            end
          end)
        end,
      })
    end,
    keys = {
      {
        "<leader>f",
        function()
          Snacks.picker.grep()
        end,
        desc = "Live grep",
        mode = { "n" },
      },
      {
        "<leader>f",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "x" },
      },
      {
        "<leader>b",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
        mode = { "x" },
      },
      {
        "<F7>",
        function()
          Snacks.picker.undo()
        end,
        desc = "Buffers",
      },
      {
        "<leader>lg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
        mode = { "x" },
      },
    },
    ---@type snacks.Config
    opts = {
      dashboard = {
        sections = {
          {
            section = "terminal",
            cmd = "pokemon-colorscripts -r --no-title; sleep .1",
            random = 10,
            pane = 1,
            height = 30,
            width = 40,
          },
          {
            icon = " ",
            key = "s",
            desc = "Open Session",
            action = ":lua require('persistence').select()",
            pane = 2,
            padding = 1,
          },
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = ":lua Snacks.dashboard.pick('files')",
            pane = 2,
            padding = 1,
          },
          {
            icon = "󰒲 ",
            key = "L",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
            pane = 2,
            padding = 1,
          },
          {
            icon = " ",
            key = "q",
            desc = "Quit",
            action = ":qa",
            pane = 2,
            padding = 1,
          },
          { section = "startup", pane = 2 },
        },
      },
      bigfile = {},
      lazygit = {},
      image = {},
      picker = {
        win = {
          input = {
            keys = {
              ["<c-l>"] = { "qflist", mode = { "i", "n" } },
              ["<Esc>"] = { "close", mode = "i" },
            },
          },
        },
      },
    },
  },
}
