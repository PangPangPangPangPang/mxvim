local M = {}
M.setup = function()
    vim.defer_fn(function ()
        vim.cmd([[ PackerLoad vim-fugitive ]])
    end, 200)
end
return M
