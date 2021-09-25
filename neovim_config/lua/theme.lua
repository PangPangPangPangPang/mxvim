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

-- color: #FFFFFF
-- percent >= 0 && percent < 1
M.shade = function (color, percent)
    local r = string.format("%02x", tonumber(string.sub(color, 2, 3), 16) * percent);
    local g = string.format("%02x", tonumber(string.sub(color, 4, 5), 16) * percent);
    local b = string.format("%02x", tonumber(string.sub(color, 6, 7), 16) * percent);
    return string.format("#%s%s%s", r, g, b)
end
return M;
