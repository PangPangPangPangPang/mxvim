return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    dependencies = {
      "bercly0b/lualine-lsp-progress",
    },
  },
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
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
  {
    "lukas-reineke/indent-blankline.nvim",
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
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
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
          "fzf",
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
        },
        user_default_options = {
          css = true,
          css_fn = true,
          names = false,
          tailwind = true,
          virtualtext_inline = true,
          mode = "virtualtext",
          virtualtext = "󱓻",
        },
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
    -- enabled = false,
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
    event = "VeryLazy",
    enabled = mxvim.enable_cursor,
    config = function()
      require("config._cursor").config()
    end,
  },

  { -- better statuscolumn
    "luukvbaal/statuscol.nvim",
    -- branch = "0.10",
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
        ft_ignore = { "neo-tree", "neo-tree-popup", "alpha", "lazy", "mason", "nofile", "NvimTree" },
        segments = segments,
      }
    end,
    config = function(_, opts)
      require("statuscol").setup(opts)
    end,
  },
  {
    "tadaa/vimade",
    event = "VeryLazy",
    opts = {
      -- Recipe can be any of 'default', 'minimalist', 'duo', and 'ripple'
      -- Set animate = true to enable animations on any recipe.
      -- See the docs for other config options.
      recipe = { "default", { animate = true } },
      ncmode = "windows", -- use 'windows' to fade inactive windows
      fadelevel = 0.4, -- any value between 0 and 1. 0 is hidden and 1 is opaque.
      tint = {
        -- bg = {rgb={0,0,0}, intensity=0.3}, -- adds 30% black to background
        -- fg = {rgb={0,0,255}, intensity=0.3}, -- adds 30% blue to foreground
        -- fg = {rgb={120,120,120}, intensity=1}, -- all text will be gray
        -- sp = {rgb={255,0,0}, intensity=0.5}, -- adds 50% red to special characters
        -- you can also use functions for tint or any value part in the tint object
        -- to create window-specific configurations
        -- see the `Tinting` section of the README for more details.
      },

      -- Changes the real or theoretical background color. basebg can be used to give
      -- transparent terminals accurating dimming.  See the 'Preparing a transparent terminal'
      -- section in the README.md for more info.
      -- basebg = [23,23,23],
      blocklist = {
        custom = {
          highlights = {
            "/^Avante.*/",
          },
        },
      },
      basebg = "",
      -- prevent a window or buffer from being styled. You
      -- Link connects windows so that they style or unstyle together.
      -- Properties are matched against the active window. Same format as blocklist above
      link = {},
      groupdiff = true, -- links diffs so that they style together
      groupscrollbind = false, -- link scrollbound windows so that they style together.
      -- enable to bind to FocusGained and FocusLost events. This allows fading inactive
      -- tmux panes.
      enablefocusfading = false,
      -- Time in milliseconds before re-checking windows. This is only used when usecursorhold
      -- is set to false.
      checkinterval = 1000,
      -- enables cursorhold event instead of using an async timer.  This may make Vimade
      -- feel more performant in some scenarios. See h:updatetime.
      usecursorhold = false,
      -- when nohlcheck is disabled the highlight tree will always be recomputed. You may
      -- want to disable this if you have a plugin that creates dynamic highlights in
      -- inactive windows. 99% of the time you shouldn't need to change this value.
      nohlcheck = true,
    },
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}