local M = {}
local colors = require("theme").colors(0.6)
M.config = function()
  M.custom_handlers()
  M.set_keymap()
end

M.set_keymap = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "General LSP Attach",
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      M.set_diagnostic(client)

      vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      if not mxvim.enable_action_preview then
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
      end
      vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { buffer = bufnr, desc = "Code lens" })
      vim.keymap.set({ "n", "v" }, "<leader>cs", function()
        -- vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
        vim.lsp.buf.code_action({ context = { only = { "source.removeUnusedImports" } }, apply = true })
      end, { buffer = bufnr, desc = "Organize imports" })
      vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
      -- Setup keymaps
      vim.keymap.set("n", "[e", function()
        vim.diagnostic.goto_prev({ float = true })
      end, { buffer = bufnr, desc = "Diagnostic" })
      vim.keymap.set("n", "]e", function()
        vim.diagnostic.goto_next({ float = true })
      end, { buffer = bufnr, desc = "Diagnostic" })
      vim.keymap.set(
        { "n", "i" },
        "<C-k>",
        vim.lsp.buf.signature_help,
        { buffer = bufnr, desc = "LSP: Signature help" }
      )

      if not mxvim.enable_trouble then
        vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, { buffer = bufnr, desc = "Definition" })
        vim.keymap.set("n", "<leader>cd", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Declaration" })
        vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Implementation" })
        vim.keymap.set("n", "<leader>cr", function()
          vim.lsp.buf.references({ include_declaration = false })
        end, { buffer = bufnr, desc = "Show references" })
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })
      vim.keymap.set("n", "<leader>ch", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, { buffer = bufnr, desc = "Toggle inlay hint" })

      vim.keymap.set("n", "<leader>cl", vim.diagnostic.setloclist, { buffer = bufnr, desc = "Diagnostic list" })
      vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, { buffer = bufnr, desc = "Diagnostic float" })

      -- vim.keymap.set("n", "<leader>cp", function()
      --   vim.lsp.buf.format({
      --     async = true,
      --   })
      -- end, { buffer = bufnr, desc = "Format document" })

      vim.keymap.set(
        "n",
        "<leader>cwa",
        vim.lsp.buf.add_workspace_folder,
        { buffer = bufnr, desc = "Add workspace folder" }
      )
      vim.keymap.set(
        "n",
        "<leader>cwr",
        vim.lsp.buf.remove_workspace_folder,
        { buffer = bufnr, desc = "Remove workspace folder" }
      )
      vim.keymap.set("n", "<leader>cwl", function() end, { buffer = bufnr, desc = "List workspace folders" })
      -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      --   update_in_insert = false,
      -- })
    end,
  })
end

M.set_diagnostic = function(client)
  client.server_capabilities.documentFormattingProvider = true
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = lsp_document_highlight,
      pattern = "*",
      callback = function()
        require("config._lsp_config").show_cursor_virt_diagnostic()
      end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = lsp_document_highlight,
      pattern = "*",
      callback = function()
        require("config._lsp_config").hide_cursor_diagnostic()
      end,
    })
    vim.api.nvim_create_autocmd("CursorMovedI", {
      group = lsp_document_highlight,
      pattern = "*",
      callback = function()
        require("config._lsp_config").hide_cursor_diagnostic()
      end,
    })
    vim.cmd("hi! default link DiagnosticVirtualTextError Comment")
    vim.cmd("hi! default link DiagnosticVirtualTextHint Comment")
    vim.cmd("hi! default link DiagnosticVirtualTextInfo Comment")
    vim.cmd("hi! default link DiagnosticVirtualTextWarn Comment")

    vim.cmd(
      string.format(
        [[
		hi! DiagnosticDefaultInfo guifg=%s
		hi! DiagnosticUnderlineError gui=undercurl term=undercurl guisp=%s guifg=none
		hi! DiagnosticUnderlineHint gui=undercurl term=undercurl guisp=%s guifg=none
		hi! DiagnosticUnderlineWarn gui=undercurl term=undercurl guisp=%s guifg=none
		hi! DiagnosticUnderlineInfo gui=undercurl term=undercurl guisp=%s guifg=none
		hi! DiagnosticSignError gui=none guifg=%s
		hi! DiagnosticSignHint gui=none guifg=%s
		hi! DiagnosticSignWarn gui=none guifg=%s
		hi! DiagnosticSignInfo gui=none guifg=%s
		highlight! link LspReference %s
		highlight! link LspReferenceText LspReference
		highlight! link LspReferenceRead LspReference
		highlight! link LspReferenceWrite LspReference
		]],
        colors.bg,
        colors.red,
        colors.blue,
        colors.yellow,
        colors.blue,
        colors.red,
        colors.blue,
        colors.yellow,
        colors.blue,
        colors.highlight ~= nil and colors.highlight or "Visual"
      )
    )
  end
end

M.custom_handlers = function()
  if mxvim.enable_inlay_hint then
    vim.lsp.inlay_hint.enable()
  end
  local icon = require("theme").lsp_icon
  vim.diagnostic.config({
    virtual_text = false,
    -- virtual_text = {
    -- 	spacing = 2,
    -- },
    underline = true,
    update_in_insert = false,
    float = {
      severity_sort = true,
      source = "if_many",
      show_header = true,
      focusable = true,
      border = require("theme").border,
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icon.error,
        [vim.diagnostic.severity.WARN] = icon.warn,
        [vim.diagnostic.severity.HINT] = icon.hint,
        [vim.diagnostic.severity.INFO] = icon.info,
      },
      numhl = {
        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      },
    },
  })
end

_G.show_line_diagnostics_namespace = vim.api.nvim_create_namespace("show_line_diagnostics_namespace")

M.hide_cursor_diagnostic = function()
  local namespace = _G.show_line_diagnostics_namespace
  vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
end

M.show_cursor_virt_diagnostic = function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local lnum = pos[1] - 1
  local col = pos[2]
  local diagnostics = vim.diagnostic.get(0, { lnum = lnum })
  if vim.tbl_isempty(diagnostics) then
    return
  end
  local line_length = #vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, true)[1]
  diagnostics = vim.tbl_filter(function(d)
    return d.lnum == lnum and math.min(d.col, line_length - 1) <= col and (d.end_col >= col or d.end_lnum > lnum)
  end, diagnostics)
  if next(diagnostics) == nil then
    return
  end
  local lines = {}
  for _, diagnostic in ipairs(diagnostics) do
    local prefix = string.format("%s: ", diagnostic.source)
    local message_lines = vim.split(diagnostic.message, "\n")
    table.insert(lines, prefix .. message_lines[1])
    for j = 2, #message_lines do
      table.insert(lines, string.rep(" ", #prefix) .. message_lines[j])
    end
  end
  local namespace = _G.show_line_diagnostics_namespace

  local raw_line = ""
  for _, line in ipairs(lines) do
    raw_line = string.format("%s 󱓻 %s", raw_line, line)
  end
  vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
  vim.api.nvim_buf_set_extmark(0, namespace, lnum, -1, {
    virt_text = { { raw_line, "Comment" } },
    virt_text_pos = "eol",
    hl_mode = "combine",
  })
end

M.show_cursor_diagnostic = function()
  vim.diagnostic.open_float(
    nil,
    { focusable = true, border = require("theme").border, scope = "cursor", source = "always" }
  )
end

return M