local M = {}
M.textobj_setup = function ()
    vim.defer_fn(function ()
        vim.cmd([[ PackerLoad vim-textobj-user ]])
    end, 1000)
end
return M;
