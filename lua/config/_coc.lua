local M = {}
M.config = function()
    local api = vim.api
    api.nvim_command('source ~/.config/nvim/viml/coc.vim')
end

return M;
