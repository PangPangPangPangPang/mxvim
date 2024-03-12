local M = {}
M.config = function()
  local colors = require("theme").colors()
  local green = colors.green
  local shade_green = require("theme").shade(colors.green, 0.6, true)
  local lsp_icon = require("theme").lsp_icon
  require("incline").setup({
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      if filename == "" then
        filename = "[No Name]"
      end

      local function get_git_diff()
        local icons = { removed = "○ ", changed = "○ ", added = "○ " }
        local signs = vim.b[props.buf].gitsigns_status_dict
        local labels = {}
        if signs == nil then
          return labels
        end
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. require("utils").capitalize_first_letter(name) })
          end
        end
        if #labels > 0 then
          table.insert(labels, { " ▏ ", group = "NonText"})
        end
        return labels
      end

      local function get_diagnostic_label()
        local icons = { error = lsp_icon.error, warn = lsp_icon.warn, info = lsp_icon.info, hint = lsp_icon.hint }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
          end
        end
        if #label > 0 then
          table.insert(label, { " ▏ ", group = "NonText"})
        end
        return label
      end

      return {
        { get_diagnostic_label() },
        { get_git_diff() },
        {
          filename .. " ",
          gui = vim.bo[props.buf].modified and "bold,italic" or "bold",
          guifg = require("utils").is_buffer_active(props.buf) and green or shade_green,
        },
      }
    end,
  })
end
return M