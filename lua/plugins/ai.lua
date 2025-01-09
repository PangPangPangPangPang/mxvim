return {
  {
    "monkoose/neocodeium",
    enabled = mxvim.enable_codeium,
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
          "NeogitCommitMessage",
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
    "yetone/avante.nvim",
    -- event = "VeryLazy",
    lazy = true,
    version = false,
    keys = {
      { "<F4>", "<cmd>AvanteToggle<cr>", mode = { "n", "i" }, desc = "Open AI" },
    },
    opts = {
      provider = "gemini",
      auto_suggestions_provider = "copilot",
      copilot = {
        model = "claude-3.5-sonnet",
      },
      gemini = {
        model = "gemini-2.0-flash-thinking-exp-1219",
      },
      behaviour = {
        auto_suggestions = not mxvim.enable_codeium, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      },
      mappings = {
        suggestion = {
          accept = "<C-Enter>",
          next = "<C-;>",
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        "zbirenbaum/copilot.lua",
        config = function()
          require("copilot").setup({})
        end,
      }, -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}