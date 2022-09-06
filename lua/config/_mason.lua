local M = {}
M.setup = function()
    vim.defer_fn(function()
        vim.cmd([[
        PackerLoad nvim-lspconfig
        PackerLoad mason.nvim
        PackerLoad mason-lspconfig.nvim
        ]])
    end, 300)
end
M.config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "sumneko_lua",
            "rust_analyzer",
            "tsserver",
            "sourcekit",
            "jsonls",
            "cssls",
            "html",
            "bashls",
        },
    })
    require("mason-lspconfig").setup_handlers({
        function (server_name) -- default handler (optional)
            local lsp_config = require('config._lsp_config');
            local config = lsp_config.make_config()
            require("lspconfig")[server_name].setup(config)
        end,
    })
    vim.cmd([[ LspStart ]])
end
return M
