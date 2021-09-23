local M = {}
M.setup = function()
    vim.defer_fn(function ()
        vim.cmd([[ PackerLoad vim-fugitive ]])
    end, 1000)
end
return M
