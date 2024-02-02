return {
  {
    "glepnir/galaxyline.nvim",
    enabled = mxvim.current_line == "galaxy",
    branch = "main",
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    dependencies = {
      "bercly0b/lualine-lsp-progress",
    },
    enabled = mxvim.current_line == "lualine",
  },
  {
    "folke/noice.nvim",
    event = "VimEnter",
    opts = {
      cmdline = {
        format = {
          search_down = {
            view = "cmdline",
          },
          search_up = {
            view = "cmdline",
          },
        },
      },
      lsp = {
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50, -- Debounce lsp signature help request by 50ms
          },
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {}, -- merged with defaults from documentation
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "luochen1990/rainbow",
    enabled = not mxvim.enable_treesitter,
    lazy = true,
    event = "VeryLazy",
    init = function()
      local colors = require("theme").colors()
      vim.g.rainbow_active = 1
      vim.g.rainbow_conf = { guifgs = { colors.magenta, colors.cyan, colors.purple, colors.yellow } }
    end,
    config = function()
      vim.cmd("RainbowToggleOn")
    end,
  },
  -- -	g.indentLine_char = '▏'
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = true,
    event = "VeryLazy",
    opts = {
      indent = {
        char = "▏", -- Thiner, not suitable when enable scope
        tab_char = "▏",
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
      },
      scope = {
        -- Rely on treesitter, bad performance
        enabled = false,
        -- highlight = highlight,
      },
    },
    config = function(_, opts)
      require("config._indentline").setupIndent(opts)
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "lewis6991/satellite.nvim",
    enable = vim.fn.has("nvim-1.0") == 1,
    lazy = true,
    config = function()
      require("config._scrollbar").config()
    end,
  },
  {
    "RishabhRD/nvim-cheat.sh",
    lazy = true,
    config = function()
      vim.g.cheat_default_window_layout = "float"
    end,
    cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
    dependencies = {
      "RishabhRD/popfix",
    },
  },
  {
    "romainl/vim-cool",
    init = function()
      vim.g.CoolTotalMatches = 1
    end,
  },
  {
    "psliwka/vim-smoothie",
    enabled = false,
    init = function()
      vim.g.smoothie_base_speed = 20
    end,
  },
  {
    "chentoast/marks.nvim",
    enabled = false,
    lazy = true,
    config = function()
      require("config._mark").config()
    end,
  },
  {
    "PangPangPangPangPang/prettier-number-line.nvim",
    enabled = not mxvim.enable_statuscol,
    lazy = true,
    event = "VimEnter",
    config = function()
      -- current virtual
      require("prettier-number-line").setup({
        mode = "current",
        show_col = false,
        exclusive_filetype = { "fugitive" },
        col_highlight = "VertSplit",
      })
    end,
  },
  {
    "b0o/incline.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("config._incline").config()
    end,
  },
  { -- better statuscolumn
    "luukvbaal/statuscol.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = function()
      vim.cmd([[hi! LineNr guifg=bg]])
      local builtin = require("statuscol.builtin")
      return {
        ft_ignore = { "neo-tree", "neo-tree-popup", "alpha", "lazy", "mason", "nofile" },
        segments = {
          {
            text = { builtin.lnumfunc },
            click = "v:lua.ScLa",
          },
          {
            sign = { name = { "GitSigns" }, text = { ".*" }, maxwidth = 1, colwidth = 1, wrap = true },
            fillchar = "%#LineNr#%=│",
            click = "v:lua.ScSa",
          },
          -- {
          --   text = { builtin.foldfunc, " " },
          --   fillchar = "",
          -- },
          {
            text = {
              function(args)
                args.fold.close = ""
                args.fold.open = ""
                args.fold.sep = "▕"
                return builtin.foldfunc(args)
              end,
            },
            click = "v:lua.ScFa",
          },
        },
      }
    end,
    init = function() end,
    config = function(_, opts)
      require("statuscol").setup(opts)
    end,
  },
  {
    "levouh/tint.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("tint").setup({
        saturation = 0.6, -- Saturation to preserve
        transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
        tint_background_colors = false, -- Tint background portions of highlight groups
        highlight_ignore_patterns = { "WinSeparator", "Status.*", "LineNr" }, -- Highlight group patterns to ignore, see `string.find`
      })
    end,
  },
}