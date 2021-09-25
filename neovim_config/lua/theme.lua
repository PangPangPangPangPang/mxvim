mxvim.init_theme = false
local M = {}
M.theme = function (name)
    return {
        name,
        opt = true,
        setup = function ()
            if mxvim.init_theme == false then
                require('colorscheme.' .. mxvim.current_theme).setup();
                mxvim.init_theme = true
            end
        end,
        config = function()
            require('colorscheme.' .. mxvim.current_theme).config();
            require('config._tree').theme();
            require('config._galaxyline');
        end
    }
end
return M;
