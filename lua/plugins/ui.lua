return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    dependencies = {
      "bercly0b/lualine-lsp-progress",
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("config._noice").setup()
    end,
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
    enabled = not mxvim.enable_hlchunk,
    lazy = true,
    main = "ibl",
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
        highlight = { "CursorLineNr" },
      },
    },
    config = function(_, opts)
      require("config._indentline").setup(opts)
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    enabled = mxvim.enable_hlchunk,
    event = { "UIEnter" },
    config = function()
      require("config._indentline").setup_hlchunk()
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    enabled = not mxvim.enable_hlchunk,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "NvimTree",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function()
      require("mini.indentscope").setup({
        symbol = "▏",
        options = { try_as_border = true },
      })
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Yellowfg" })
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
        -- signs_on_startup = { "all" },
        signs_on_startup = {},
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
    enabled = not mxvim.enable_cursor,
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
    enabled = mxvim.enable_cursor,
    config = function()
      require("config._cursor").config()
    end,
  },

  { -- better statuscolumn
    "luukvbaal/statuscol.nvim",
		branch = "0.10",
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