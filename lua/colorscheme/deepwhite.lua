local M = {}
M.config = function()
	require('deepwhite').setup({
    -- If you have some anti-blue light setting (f.lux, light bulb, or low blue light mode monitor),
    -- turn it on, this will set the background color to a cooler color to prevent the background from being too warm.
    low_blue_light = true
})
	        vim.cmd [[colorscheme deepwhite]]

end

M.colors = function()
	return {
		fg = '#f1e9d2',       -- light text color
		bg = '#252623',       -- background color
		yellow = '#dbb671',
		cyan = '#70c2be',
		darkblue = '#57a5e5',
		green = '#8fb573',
		orange = '#ff9966',
		purple = '#aaaaff',
		magenta = '#f08080',
		blue = '#57a5e5',
		red = '#e75a7c',
		line_fg = '#252623',
	}
end
return M