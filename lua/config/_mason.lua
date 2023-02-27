local M = {}
M.config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "rust_analyzer",
            "tsserver",
            "jsonls",
            "cssls",
            "html",
            "bashls",
        },
    })
    require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
            local lsp_config = require('config._lsp_config');
            local config = lsp_config.make_config()
            require("lspconfig")[server_name].setup(config)
        end,
    })
    require("lsp.lsp_swift").setup()
    vim.cmd([[ LspStart ]])
end
return M
