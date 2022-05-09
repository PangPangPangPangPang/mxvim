local M = {}
local lsp_config = require("config._lsp_config")
M.modify = function (config)
    config.on_attach = function (client, bufnr)
        lsp_config.set_keymap(client, bufnr)
        lsp_config.set_signature(bufnr)
    end
end
return M
