return {
  {
    "Exafunction/codeium.vim",
    enabled = mxvim.enable_codeium,
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
}