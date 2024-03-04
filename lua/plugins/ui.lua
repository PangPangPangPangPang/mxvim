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
    event = "VeryLazy",
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
        progress = {
          enabled = false,
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50, -- Debounce lsp signature help request by 50ms
          },
          view = nil, -- when nil, use defaults from documentation
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
    lazy = true,
    main = "ibl",
    -- event = "VeryLazy",
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
        enabled = true,
        highlight = { "Yellowfg" },
      },
    },
    config = function(_, opts)
      require("config._indentline").setup(opts)
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*",
          typescriptreact = { rgb_fn = true, hsl_fn = true },
          javascriptreact = { rgb_fn = true, hsl_fn = true },
        },
        user_default_options = { mode = "virtualtext" },
      })
    end,
  },
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_hl(0, "ScrollView", { link = "CursorLine" })
      require("scrollview").setup({
        diagnostics_error_symbol = "━",
        diagnostics_warn_symbol = "━",
        diagnostics_info_symbol = "━",
        diagnostics_hint_symbol = "━",
        excluded_filetypes = { "NvimTree" },
        current_only = true,
        -- base = "buffer",
        -- column = 80,
        signs_on_startup = { "all" },
        diagnostics_severities = { vim.diagnostic.severity.ERROR },
      })
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
        scrollview_base = "right",
      })
    end,
  },
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
      require("config._incline").config()
    end,
  },
  {
    "gen740/SmoothCursor.nvim",
    lazy = true,
    enabled = mxvim.enable_cursor,
    config = function()
      require("smoothcursor").setup({
        cursor = "▷ ",
        -- cursor = '▶ '
        -- cursor = "⫸ ",
        -- cursor = "㊡",
        disabled_filetypes = { "NeogitStatus", "NvimTree", "fzf" }, -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
        disable_float_win = true,
        always_redraw = false, -- Redraw the screen on each update
        speed = 100, -- Max speed is 100 to stick with your current position
        priority = 99, -- Set marker priority
      })
    end,
  },

  { -- better statuscolumn
    "luukvbaal/statuscol.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = { "gen740/SmoothCursor.nvim" },
    opts = function()
      local builtin = require("statuscol.builtin")
      local segments = {}
      if mxvim.enable_cursor then
        segments[#segments + 1] = {
          sign = { name = { ".*" }, colwidth = 2, auto = false, wrap = true },
          click = "v:lua.ScLa",
        }
      else
        segments[#segments + 1] = {
          text = { builtin.lnumfunc },
          click = "v:lua.ScLa",
        }
      end
      segments[#segments + 1] = {
        sign = { name = { "GitSigns" }, text = { ".*" }, maxwidth = 1, colwidth = 1, wrap = true },
        fillchar = "%#LineNr#%=│",
        click = "v:lua.ScSa",
      }
      if mxvim.show_fold then
        segments[#segments + 1] = {
          text = { builtin.foldfunc, " " },
          fillchar = "",
        }
      end

      return {
        ft_ignore = { "neo-tree", "neo-tree-popup", "alpha", "lazy", "mason", "nofile" },
        segments = segments,
      }
    end,
    config = function(_, opts)
      require("statuscol").setup(opts)
    end,
  },
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    config = function()
      require("tint").setup({
        tint = -45, -- Darken colors, use a positive value to brighten
        saturation = 0.4, -- Saturation to preserve
        transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
        tint_background_colors = false, -- Tint background portions of highlight groups
        highlight_ignore_patterns = { "WinSeparator", "Status.*", "LineNr" }, -- Highlight group patterns to ignore, see `string.find`
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
          local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
          -- Do not tint `terminal` or floating windows, tint everything else
          return buftype == "terminal" or floating or buftype == "nofile"
        end,
      })
    end,
  },
}