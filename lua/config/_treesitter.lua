local colors = require("theme").colors()
local theme = require("theme")
local safe_require = require("utils").safe_require
require("nvim-treesitter.configs").setup({
  -- npm i -g tree-sitter-cli
  -- ensure_installed = 'maintained',     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "None",
      ["variable"] = "None",
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
  indent = { enable = false },
  textobjects = {
    move = {
      enable = false,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = false,
      swap_next = { ["<leader>a"] = "@parameter.inner" },
      swap_previous = { ["<leader>A"] = "@parameter.inner" },
    },
    select = {
      enable = false,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
  },
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

local rainbow_delimiters = require("rainbow-delimiters")
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