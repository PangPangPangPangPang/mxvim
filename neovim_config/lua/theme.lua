local M = {}
M.theme = function (name)
    return {
        name,
        opt = true,
        setup = function ()
            require('colorscheme.' .. vim.g.current_theme).setup();
        end,
        config = function()
            require('colorscheme.' .. vim.g.current_theme).config();
            require('config._tree').theme();
        end
    }
end
return M;
