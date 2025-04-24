return {
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "nvim-lua/lsp-status.nvim" },
      { "iguanacucumber/magazine.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require("config._mason").config()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = {
      {
        "lukas-reineke/lsp-format.nvim",
        config = function()
          require("lsp-format").setup({
            typescriptreact = {
              order = { "vtsls", "null-ls" },
              exclude = { "vtsls" },
            },
          })
        end,
      },
    },
    opts = {
      inlay_hints = { enabled = true },
      codelens = {
        enabled = true,
      },
    },
    config = function()
      require("config._lsp_config").config()
    end,
  },
  -- defer all NeoVim diagnostics for a less distracting coding experience
  {
    "yorickpeterse/nvim-dd",
    event = "VeryLazy",
    config = function()
      require("dd").setup({
        timeout = 0,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    enabled = mxvim.enable_blink,
    event = "LspAttach",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    opts = {
      keymap = {
        preset = "enter",
        ["<C-e>"] = { "fallback" },
        ["<C-n>"] = { "show", "select_next", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          dot_repeat = false,
        },
        menu = {
          border = "none",
          winblend = 30,
          draw = { treesitter = { "lsp" } },
        },
        documentation = {
          auto_show = true,
          window = {
            winblend = 30,
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          winblend = 30,
        },
      },
      cmdline = {
        completion = {
          list = {
            selection = {
              preselect = false,
            },
          },
          menu = {
            auto_show = true,
          },
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    -- name = "nvim-cmp",
    -- lazy = true,
    enabled = not mxvim.enable_blink,
    event = "VeryLazy",
    dependencies = {
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      {
        "hrsh7th/cmp-vsnip",
        dependencies = {
          "hrsh7th/vim-vsnip-integ",
          "hrsh7th/vim-vsnip",
          "rafamadriz/friendly-snippets",
        },
      },
      {
        "quangnguyen30192/cmp-nvim-tags",
      },
    },
    config = function()
      require("config._nvim_cmp").config()
    end,
  },
  {
    "folke/trouble.nvim",
    enabled = mxvim.enable_trouble,
    lazy = true,
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    config = function()
      require("config._lsp_trouble").config()
    end,
  },
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<F2>", "<cmd>AerialToggle<cr>", { "n", "i" } },
    },
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  require("lsp.lsp_ts").ts_tools,
  require("lsp.lsp_lua").lazydev(),
  {
    "jay-babu/mason-null-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "nvimtools/none-ls.nvim",
        dependencies = {
          "gbprod/none-ls-luacheck.nvim",
          "nvimtools/none-ls-extras.nvim",
        },
      },
    },
    config = function()
      require("lsp.lsp_nullls").config()
    end,
  },
  {
    "wojciech-kulik/xcodebuild.nvim",
    enabled = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("xcodebuild").setup({
        -- put some options here or leave it empty to use default settings
      })
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    enabled = mxvim.enable_action_preview,
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions, { desc = "Code action" })
      local hl = require("actions-preview.highlight")

      require("actions-preview").setup({
        highlight_command = {
          hl.delta("delta --no-gitconfig --side-by-side"),
          function()
            return require("actions-preview.highlight").delta()
          end,
        },
        snacks = {
          layout = { preset = "default" },
        },
      })
    end,
  },
  {
    "dnlhc/glance.nvim",
    event = "VeryLazy",
    config = function()
      require("glance").setup({
        -- your configuration
      })
      -- Lua
      vim.keymap.set("n", "<leader>cgd", "<CMD>Glance definitions<CR>")
      vim.keymap.set("n", "<leader>cgr", "<CMD>Glance references<CR>")
      vim.keymap.set("n", "<leader>cgy", "<CMD>Glance type_definitions<CR>")
      vim.keymap.set("n", "<leader>cgm", "<CMD>Glance implementations<CR>")
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      local lighter = require("theme").colors(0.2)
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { fg = "none", bg = lighter.magenta })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { fg = "none", bg = lighter.magenta })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { fg = "none", bg = lighter.magenta })
      -- default configuration
      require("illuminate").configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          "lsp",
        },
        -- delay: delay in milliseconds
        delay = 100,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          "dirbuf",
          "dirvish",
          "fugitive",
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
        -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        -- See `:help mode()` for possible values
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
        -- See `:help mode()` for possible values
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = nil,
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
        -- min_count_to_highlight: minimum number of matches required to perform highlighting
        min_count_to_highlight = 1,
        -- should_enable: a callback that overrides all other settings to
        -- enable/disable illumination. This will be called a lot so don't do
        -- anything expensive in it.
        should_enable = function(bufnr)
          return true
        end,
        -- case_insensitive_regex: sets regex case sensitivity
        case_insensitive_regex = false,
      })
    end,
  },
}