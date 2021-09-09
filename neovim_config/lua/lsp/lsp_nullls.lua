local M = {}
M.config = function ()
        local lspconfig = require('lspconfig')
        local config = require('config._lsp_config').make_config()
        local null_ls = require("null-ls")
        -- pip3 install codespell
        -- yarn add global eslint_d
        local sources = {
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.diagnostics.codespell,
            null_ls.builtins.diagnostics.luacheck,
            null_ls.builtins.formatting.eslint_d,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier
        }
        null_ls.config({sources = sources})
        lspconfig["null-ls"].setup(config)
end
return M;
