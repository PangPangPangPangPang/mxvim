local M = {}
M.config = function (on_attach)
    local eslint = {
        lintCommand = "eslint -f visualstudio --stdin --stdin-filename ${INPUT}",
        lintIgnoreExitCode = true,
        lintStdin = true,
        lintFormats = {"%f:%l:%c: %m"}
    }
    local languages = {
        lua = {formatCommand = "lua-format -i", formatStdin = true},
        typescript = eslint,
        typescriptreact = eslint,
        javascript = eslint,
        javascriptreact = eslint
    }
    local efm_config = {
        filetypes = vim.tbl_keys(languages),
        root_dir = require("lspconfig/util").root_pattern("package.json", ".eslintrc", ".git"),
        init_options = {
            hover = true,
            documentFormatting = true,
            documentSymbol = true,
            codeAction = true,
            completion = true
        },
        settings = {
            languages = languages,
            version = 2,
            rootMarkers = {".eslintrc", ".eslintrc.js", ".git/", "yarn.lock", "lerna.json"}
        },
        on_attach = on_attach
    }
    return efm_config
end
return M