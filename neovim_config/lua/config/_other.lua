local M = {}
M.textobj_setup = function ()
    vim.defer_fn(function ()
        vim.cmd([[ PackerLoad vim-textobj-user ]])
    end, 200)
end
M.signature_setup = function ()
    vim.defer_fn(function ()
        vim.cmd([[ PackerLoad vim-textobj-user ]])
    end, 200)
end
return M;
