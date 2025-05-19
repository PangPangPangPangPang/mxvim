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
    "skywind3000/vim-gpt-commit",
    cmd = { "GptCommit" },
    init = function()
      local dmap = require("utils").dmap
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = {
          "gitcommit",
        },
        callback = function()
          dmap({ "i", "v" }, "<c-c>", "<cmd>GptCommit<cr>")
        end,
      })
    end,

    config = function()
      -- if you don't want to set your api key directly, add to your .zshrc:
      -- export OPENAI_API_KEY='sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      -- vim.g.gpt_commit_key = os.getenv("OPENAI_API_KEY")
      -- uncomment this line below to enable proxy
      -- vim.g.gpt_commit_proxy = 'socks5://127.0.0.1:1080'

      -- uncomment the following lines if you want to use Ollama:
      vim.g.gpt_commit_engine = "ollama"
      vim.g.gpt_commit_ollama_url = "http://127.0.0.1:11434/api/chat"
      vim.g.gpt_commit_ollama_model = "llama3"
      vim.g.gpt_commit_concise = 1
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    keys = {
      {
        "<F4>",
        "<cmd>CodeCompanionChat Toggle<CR>",
        mode = { "n", "i" },
        desc = "Open AI",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "codecompanion" },
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "gemini",
        },
        inline = {
          adapter = "gemini",
        },
      },
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            model = {
              default = "gemini-2.0-flash-lite",
            },
          },
          env = {
            api_key = "GEMINI_API_KEY",
          },
        })
      end,
      display = {
        diff = {
          provider = "mini_diff",
        },
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    enabled = mxvim.ai_engine == "copilot",
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
  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("codecompanion").setup({
  --       strategies = {
  --         chat = {
  --           adapter = "gemini",
  --         },
  --         inline = {
  --           adapter = "gemini",
  --         },
  --       },
  --       -- adapters = {
  --       --   anthropic = function()
  --       --     return require("codecompanion.adapters").extend("gemini", {
  --       --       env = {
  --       --         api_key = "MY_OTHER_ANTHROPIC_KEY",
  --       --       },
  --       --     })
  --       --   end,
  --       -- },
  --     })
  --   end,
  -- },
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
}