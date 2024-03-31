local colors = require("theme").colors()
local theme = require("theme")
local safe_require = require("utils").safe_require
require("nvim-treesitter.configs").setup({
  -- npm i -g tree-sitter-cli
  -- ensure_installed = 'maintained',     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["@foo.bar"] = "None",
      ["@variable"] = "None",
    },
  },
  sync_install = false,
  auto_install = true,

  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = { enable = true },
  autotag = { enable = true },
  autopairs = { enable = true },
  rainbow = {
    colors = {
      colors.magenta,
      colors.orange,
      colors.yellow,
      colors.green,
      colors.blue,
      colors.cyan,
      colors.blue,
    },
    enable = false,
    extended_mode = true,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "<c-v>", -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
})

require("rainbow-delimiters.setup").setup({
  highlight = {
    "Redfg",
    "Yellowfg",
    "Bluefg",
    "Orangefg",
    "Greenfg",
    "Purplefg",
    "Cyanfg",
  },
})
local M = {}
M.inithlargs = function()
  safe_require("hlargs", function(hlargs)
    hlargs.setup({
      color = theme.shade(theme.extract_nvim_hl("Normal").fg, 0.2),
      excluded_filetypes = {},
      paint_arg_declarations = true,
      paint_arg_usages = true,
      hl_priority = 10000,
      excluded_argnames = {
        declarations = {},
        usages = {
          python = { "self", "cls" },
          lua = { "self" },
        },
      },
      performance = {
        parse_delay = 1,
        slow_parse_delay = 50,
        max_iterations = 400,
        max_concurrent_partial_parses = 30,
        debounce = {
          partial_parse = 3,
          partial_insert_mode = 100,
          total_parse = 700,
          slow_parse = 5000,
        },
      },
    })
    -- (You
  end)
end

return M