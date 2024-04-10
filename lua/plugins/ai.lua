return {
  {
    "Exafunction/codeium.vim",
    enabled = mxvim.enable_codeium and vim.fn.has("nvim-0.10") ~= 1,
    event = "VeryLazy",
    config = function()
      vim.g.codeium_no_map_tab = 1
      vim.keymap.set("n", "<leader>cc", function()
        return vim.fn["codeium#Chat"]()
      end, { expr = true, silent = true, desc = "Chat with codeium" })
      vim.keymap.set("i", "<C-Enter>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-'>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      -- vim.keymap.set("i", "<c-x>", function()
      --   return vim.fn["codeium#Clear"]()
      -- end, { expr = true, silent = true })
    end,
  },
  {
    "monkoose/neocodeium",
    enabled = mxvim.enable_codeium and vim.fn.has("nvim-0.10") == 1,
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()
      vim.keymap.set("i", "<C-Enter>", neocodeium.accept)
    end,
  },
}
