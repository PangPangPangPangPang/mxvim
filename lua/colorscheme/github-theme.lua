local M = {}
M.config = function()
  require("github-theme").setup({
    options = {
      transparent = false,
      hide_end_of_buffer = true,
      hide_nc_statusline = true,
      -- styles = {
      -- 	comments = 'italic,bold',
      -- 	functions = 'NONE',
      -- 	keywords = 'bold',
      -- 	variables = 'underline',
      -- },
      darken = {
        floats = true,
        sidebars = {
          enable = true,
          list = {},
        },
      },
    },

    specs = {
      -- Change the color of only the 'github_dark' theme's 'hint' color to magenta and make the 'error' color a dim red.
      github_dark = {
        diag = {
          error = "#660000",
          hint = "magenta.base",
        },
      },
      -- Change the "hint" color to the "orange" color, and make the "error" color bright red.
      all = {
        diag = {
          error = "#ff0000",
          hint = "orange",
        },
      },
    },

    -- Overwrite the highlight groups for all colorschemes
    groups = {
      all = {
        htmlTag = { fg = "palette.red", bg = "#282c34", sp = "diag.hint", style = "underline,bold" },
        DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
        -- this will remove the highlight groups
        TSField = {},
      },
    },
  })

  vim.cmd("colorscheme github_" .. mxvim.background)
end

M.colors = function()
  return {
    fg = "#e1e4e8",
    bg = "#2c2b1c",
    yellow = "#e3b341",
    cyan = "#fdaeb7",
    darkblue = "#3b8eea",
    green = "#23d18b",
    orange = "#d18616",
    purple = "#b392f0",
    magenta = "#f97583",
    blue = "#3b8eea",
    red = "#f14c4c",
  }
end
return M