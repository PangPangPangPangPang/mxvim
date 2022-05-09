local M = {}
M.modify = function(config)
    config.capabilities.offsetEncoding = { "utf-16" }
end
return M
