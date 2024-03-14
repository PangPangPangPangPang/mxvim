local M = {}
M.setup = function()
  local center_pos = {}
  if mxvim.style == "simple" then
    center_pos = {
      size = { width = "50%" },
      border = { style = "shadow", padding = { top = 1, bottom = 1, left = 1, right = 1 } },
    }
  end

  require("noice").setup({
    views = {
      cmdline_popup = center_pos,
      popupmenu = center_pos,
    },
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
        enabled = true,
        format = false,
        -- format_done = false
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
    routes = {
      {
        filter = {
          event = "lsp",
          kind = "progress",
          find = "on_open",
        },
        opts = { skip = true },
      },
    },
  })
end
return M