local M = {}
M.config = function()
  local map = require("utils").map
  -- vim.cmd([[
  -- xnoremap<silent> <leader>f :<c-u>execute 'Telescope live_grep default_text=' . GetVisualSelection(visualmode())<cr>
  -- command! -nargs=0 LS :Telescope buffers
  -- cnoreabbrev ls LS
  -- ]])
  local actions = require("telescope.actions")
  require("telescope").setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      mappings = {
        i = {
          -- To disable a keymap, put [map] = false
          -- So, to not map "<C-n>", just put
          ["<c-x>"] = false,
          -- Otherwise, just set the mapping to the function that you want it to be.
          ["<c-i>"] = actions.select_horizontal,

          -- You can perform as many actions in a row as you like
          ["<esc>"] = actions.close,
          ["<C-l>"] = actions.send_to_qflist + actions.open_qflist,
          ["<c-c>"] = { "<esc>", type = "command" },
          ["<S-up>"] = actions.preview_scrolling_up,
          ["<S-down>"] = actions.preview_scrolling_down,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<c-c>"] = false,
          ["<c-l>"] = actions.send_to_qflist + actions.open_qflist,
          ["<S-up>"] = actions.preview_scrolling_up,
          ["<S-down>"] = actions.preview_scrolling_down,
        },
      },
      path_display = { "truncate" },
      prompt_prefix = "   ",
      selection_caret = " ▶ ",
      entry_prefix = "  ",
      initial_mode = "insert",
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        horizontal = {
          mirror = false,
          prompt_position = "top",
          width = 0.75,
          preview_cutoff = 120,
        },
        vertical = {
          mirror = true,
          width = 0.50,
          prompt_position = "top",
        },
      },
      -- file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = {},
      -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      winblend = 10,
      border = true,
      borderchars = {
        " ",
        " ",
        " ",
        " ",
        " ",
        " ",
        " ",
        " ",
      },
      color_devicons = true,
      -- use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      undo = {
        use_delta = true,
        use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
        side_by_side = false,
        diff_context_lines = vim.o.scrolloff,
        entry_format = "state #$ID, $STAT, $TIME",
        time_format = "",
        mappings = {
          i = {
            -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
            -- you want to replicate these defaults and use the following actions. This means
            -- installing as a dependency of telescope in it's `requirements` and loading this
            -- extension from there instead of having the separate plugin definition as outlined
            -- above.
            ["<cr>"] = require("telescope-undo.actions").yank_additions,
            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
            ["<C-cr>"] = require("telescope-undo.actions").restore,
          },
        },
      },
      ["ui-select"] = {
        require("telescope.themes").get_cursor({
          -- even more opts
        }),

        -- pseudo code / specification for writing custom displays, like the one
        -- for "codeactions"
        -- specific_opts = {
        --   [kind] = {
        --     make_indexed = function(items) -> indexed_items, width,
        --     make_displayer = function(widths) -> displayer
        --     make_display = function(displayer) -> function(e)
        --     make_ordinal = function(e) -> string
        --   },
        --   -- for example to disable the custom builtin "codeactions" display
        --      do the following
        --   codeactions = false,
        -- }
      },
    },
  })
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("ui-select")
  require("telescope").load_extension("undo")
end

local zfvim = require("config._zfvimim")

---@diagnostic disable-next-line: lowercase-global
function findFiles()
  if zfvim.is_zf_load then
    stop_zfvimim(0)
  end
  vim.cmd("Telescope find_files")
end

M.hl_telescope = function()
  local colors = require("theme").colors()
  vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = colors.bg, bg = colors.green })
  vim.api.nvim_set_hl(0, "TelescopeMatching", { bold = true, fg = colors.red })
  if mxvim.style == "simple" then
  local shade_colors = require("theme").colors(0.8)
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bold = true, bg = colors.red, fg = colors.fg })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bold = true, bg = shade_colors.bg, fg = colors.fg })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bold = true, bg = shade_colors.bg, fg = colors.fg })
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bold = true, bg = colors.green, fg = colors.fg })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bold = true, bg = colors.blue, fg = colors.fg })
  else
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bold = true, fg = colors.red })
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bold = true, fg = colors.green })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bold = true, fg = colors.blue })
  end
end

return M