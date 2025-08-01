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
    "olimorris/codecompanion.nvim",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    init = function()
      local dmap = require("utils").dmap
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = {
          "gitcommit",
        },
        callback = function()
          dmap("i", "<c-c>", "<esc><cmd>CodeCompanion /commit_message<cr>")
        end,
      })
    end,
    keys = {
      {
        -- "<F4>",
        "<c-l>",
        "<cmd>CodeCompanionChat Toggle<CR>",
        mode = { "n", "i" },
        desc = "Open AI",
      },
      {
        "<c-i>",
        ":CodeCompanion ",
        mode = { "v", "n" },
        desc = "Open AI inline assistant",
      },
    },
    dependencies = {
      "franco-ruggeri/codecompanion-spinner.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      {
        "echasnovski/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
          })
        end,
      },
      {
        "HakonHarnes/img-clip.nvim",
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = "[Image]($FILE_PATH)",
              use_absolute_path = true,
            },
          },
        },
      },
    },
    opts = {
      prompt_library = {
        ["Commit Message"] = {
          strategy = "inline",
          description = "Generate a commit message",
          opts = {
            short_name = "commit_message",
            auto_submit = true,
            placement = "replace",
          },
          prompts = {
            {
              role = "user",
              content = function()
                return string.format(
                  [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

` ` `diff
%s
` ` `

When unsure about the module names to use in the commit message, you can refer to the last 20 commit messages in this repository:

` ` `
%s
` ` `

Output only the commit message without any explanations and follow-up suggestions.
]],
                  vim.fn.system("git diff --no-ext-diff --staged"),
                  vim.fn.system('git log --pretty=format:"%s" -n 20')
                )
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
      extensions = {
        spinner = {},
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
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