local M = {}
M.config = function()
    local api = vim.api
    api.nvim_command('source ~/.config/nvim/lazy_plugin_config/coc.vim')
end

return M;
