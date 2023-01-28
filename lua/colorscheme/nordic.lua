
local M = {}
M.config = function()
    require(mxvim.current_theme) .load()

end

M.colors = function()
    local colors = require 'nordic.colors'
	return {
		fg = "#DCD7BA",
		bg = "#16161D",
		light_fb = "#717C7C",
		light_bg = "#1F1F28",
		fg_green = "#76946A",
		yellow = "#E6C384",
		cyan = "#7AA89F",
		darkblue = "#658594",
		green = "#98BB6C",
		orange = "#FFA066",
		purple = "#957FB8",
		magenta = "#D27E99",
		blue = colors.blue0,
		red = "#FF5D62",
        line_fg = "#16161D",
	}
end
return M
