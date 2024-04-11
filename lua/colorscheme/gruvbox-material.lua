local M = {}
M.config = function()
	-- hard medium soft
	vim.g.gruvbox_material_background = 'hard'
	vim.g.gruvbox_material_enable_bold = 1
	vim.g.gruvbox_material_enable_italic = 1
	-- original material mix
	vim.g.gruvbox_material_palette = 'original'
	vim.cmd('colorscheme ' .. mxvim.current_theme)
end


M.colors = function()
	return {
		fg = '#ebdbb2',           -- light text color
		bg = '#3c3836',           -- background color
		yellow = '#fabd2f',
		cyan = '#8ec07c',
		darkblue = '#83a598',
		green = '#b8bb26',
		orange = '#fe8019',
		purple = '#924f79',
		magenta = '#d3869b',
		blue = '#83a598',
		red = '#fb4934'
	}
end
return M