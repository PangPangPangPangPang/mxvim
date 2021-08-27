local M = {}
M.config = function ()
    local eslint = {
        lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
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
        init_options = {
            documentFormatting = true,
            documentSymbol = true,
            codeAction = true,
            completion = true
        },
        settings = {
            languages = languages,
            verson = 2,
            rootMarkers = {".eslintrc.js", ".git/", "yarn.lock", "lerna.json"}
        },
        on_attach = on_attach
    }
    return efm_config
end
return M
