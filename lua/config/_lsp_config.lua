local M = {}
local colors = require("theme").colors(0.6)
local cmd = vim.cmd
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

      -- Setup keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })
      -- vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help,
      -- { buffer = bufnr, desc = "LSP: Signature help" })
      vim.keymap.set("n", "[e", function()
        vim.diagnostic.goto_prev({ float = true })
      end, { buffer = bufnr, desc = "Diagnostic" })
      vim.keymap.set("n", "]e", function()
        vim.diagnostic.goto_next({ float = true })
      end, { buffer = bufnr, desc = "Diagnostic" })

      vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, { buffer = bufnr, desc = "Definition" })
      vim.keymap.set("n", "<leader>cd", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Declaration" })
      vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Implementation" })
      vim.keymap.set("n", "<leader>cr", function()
        vim.lsp.buf.references({ include_declaration = false })
      end, { buffer = bufnr, desc = "Show references" })

      vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
      vim.keymap.set("n", "<leader>cl", vim.diagnostic.setloclist, { buffer = bufnr, desc = "Diagnostic list" })
      vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, { buffer = bufnr, desc = "Diagnostic float" })

      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
      vim.keymap.set("n", "<leader>cp", function()
        vim.lsp.buf.format({
          async = true,
        })
      end, { buffer = bufnr, desc = "Format document" })

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
      if vim.fn.has("nvim-0.10") == 1 then
        if client and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint(bufnr, true)
        end
      end
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = true,
      })
    end,
  })
end

M.set_diagnostic = function(client)
  client.server_capabilities.documentFormattingProvider = true
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    local show_diag = "autocmd CursorHold * lua require('config._lsp_config').show_cursor_virt_diagnostic()"
    cmd([[ augroup lsp_document_highlight ]])
    cmd([[ autocmd! * <buffer> ]])
    cmd([[ autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()  ]])
    cmd([[ autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight() ]])
    cmd([[ autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references() ]])
    -- cmd(show_diag)
    cmd([[ autocmd CursorMoved <buffer> lua require('config._lsp_config').hide_cursor_diagnostic() ]])
    cmd([[ autocmd CursorMovedI <buffer> lua require('config._lsp_config').hide_cursor_diagnostic() ]])
    -- cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 1000)]])
    cmd([[ augroup END ]])
    cmd([[
		hi! default link DiagnosticVirtualTextError Comment
		hi! default link DiagnosticVirtualTextHint Comment
		hi! default link DiagnosticVirtualTextInfo Comment
		hi! default link DiagnosticVirtualTextWarn Comment
		]])

    cmd(
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

M.make_config = function()
  local safe_require = require("utils").safe_require
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  safe_require("cmp_nvim_lsp", function(cmp)
    capabilities = cmp.default_capabilities(capabilities)
  end)
  local root_dir
  safe_require("lspconfig/util", function(util)
    root_dir = util.root_pattern("package.json", ".eslintrc", ".git")
  end)
  local config = {
    autostart = true,
    root_dir = root_dir,
    -- enable snippet support
    capabilities = capabilities,
  }
  return config
end

M.custom_handlers = function()
  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = mxvim.enable_cursor and opts.icon or "",
      numhl = opts.name,
    })
  end
  sign({ name = "DiagnosticSignError", icon = " " })
  sign({ name = "DiagnosticSignWarn", icon = " " })
  sign({ name = "DiagnosticSignHint", icon = " " })
  sign({ name = "DiagnosticSignInfo", icon = " " })

  local safe_require = require("utils").safe_require
  safe_require("lsputil.locations", function(locations)
    vim.lsp.handlers["textDocument/references"] = locations.references_handler
    vim.lsp.handlers["textDocument/definition"] = locations.definition_handler
    vim.lsp.handlers["textDocument/declaration"] = locations.declaration_handler
    vim.lsp.handlers["textDocument/typeDefinition"] = locations.typeDefinition_handler
    vim.lsp.handlers["textDocument/implementation"] = locations.implementation_handler
  end)
  safe_require("lsputilsymbols", function(symbols)
    vim.lsp.handlers["textDocument/documentSymbol"] = symbols.document_handler
    vim.lsp.handlers["workspace/symbol"] = symbols.workspace_handler
  end)

  vim.diagnostic.config({
    virtual_text = false,
    -- virtual_text = {
    -- 	spacing = 2,
    -- },
    signs = function()
      return true
    end,
    underline = true,
    update_in_insert = true,
    float = {
      severity_sort = true,
      source = "if_many",
      show_header = true,
      focusable = true,
      border = "rounded",
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
    raw_line = string.format("%s ■ %s", raw_line, line)
  end
  vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
  vim.api.nvim_buf_set_extmark(0, namespace, lnum, -1, {
    virt_text = { { raw_line, "Comment" } },
    virt_text_pos = "eol",
    hl_mode = "combine",
  })
end

M.show_cursor_diagnostic = function()
  vim.diagnostic.open_float(nil, { focusable = true, border = "rounded", scope = "cursor", source = "always" })
end

return M