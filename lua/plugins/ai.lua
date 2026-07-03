return {
  {
    "monkoose/neocodeium",
    enabled = mxvim.ai_engine == "codeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup({
        silent = true,
      })
      local colors = require("theme").colors()
      vim.api.nvim_set_hl(0, "NeoCodeiumLabel", { fg = colors.bg, bg = colors.green })
      vim.keymap.set("i", "<C-Enter>", neocodeium.accept)
      vim.keymap.set("i", "<C-;>", function()
        require("cmp").close()
        neocodeium.cycle()
      end)
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    enabled = mxvim.ai_engine == "copilot",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    },
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<c-enter>",
            accept_word = false,
            accept_line = false,
            next = "<c-j>",
            prev = "<c-k>",
            dismiss = "<c-e>",
          },
        },
      })
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    enabled = mxvim.ai_engine == "supermaven",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-Enter>",
          clear_suggestion = "<C-;>",
          accept_word = "<C-j>",
        },
      })
    end,
  },
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "zellij",
          enabled = false,
        },
      },
    },
    init = function()
      -- In sidekick terminal buffers:
      -- <Esc>       → send Esc to the CLI process (e.g. Claude)
      -- <Esc><Esc>  → exit terminal mode (back to normal mode)
      vim.api.nvim_create_autocmd("TermOpen", {
        callback = function(ev)
          local name = vim.api.nvim_buf_get_name(ev.buf)
          if name:match("claude") or name:match("sidekick") or name:match("gemini") then
            vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = ev.buf, noremap = true, desc = "Send Esc to terminal" })
            vim.keymap.set(
              "t",
              "<Esc><Esc>",
              "<C-\\><C-n>",
              { buffer = ev.buf, noremap = true, desc = "Exit terminal mode" }
            )
            vim.keymap.set("t", "<c-l>", function()
              require("sidekick.cli").toggle({ focus = true })
            end, { buffer = ev.buf, desc = "Sidekick Toggle CLI" })
            -- Allow <C-w> window navigation from terminal mode
            for _, key in ipairs({ "h", "j", "k", "l", "w", "W", "p", "H", "J", "K", "L" }) do
              vim.keymap.set(
                "t",
                "<C-w>" .. key,
                "<C-\\><C-n><C-w>" .. key,
                { buffer = ev.buf, noremap = true, desc = "Window nav: " .. key }
              )
            end
          end
        end,
      })
      -- Auto-enter terminal mode when focusing a sidekick terminal buffer
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(ev)
          if vim.bo[ev.buf].buftype == "terminal" then
            local name = vim.api.nvim_buf_get_name(ev.buf)
            if name:match("claude") or name:match("sidekick") or name:match("gemini") then
              vim.cmd("startinsert")
            end
          end
        end,
      })
    end,
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        desc = "Sidekick Switch Focus",
        mode = { "n", "v" },
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ focus = true })
        end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<c-l>",
        function()
          require("sidekick.cli").toggle({ focus = true })
        end,
        desc = "Sidekick codex Toggle",
        mode = { "n", "v", "i", "t" },
      },
      {
        "<leader>ag",
        function()
          require("sidekick.cli").toggle({ name = "gemini", focus = true })
        end,
        desc = "Sidekick Gemini Toggle",
        mode = { "n", "v" },
      },
      {
        "<c-i>",
        function()
          require("sidekick.cli").select_prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "v" },
      },
    },
  },
}
