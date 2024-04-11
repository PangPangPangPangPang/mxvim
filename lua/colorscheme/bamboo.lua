local M = {}
M.config = function()
	-- Lua
	require('bamboo').setup {
		-- Main options --
		-- NOTE: to use the light theme, set `vim.o.background = 'light'`
		style = 'vulgaris',                                 -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
		toggle_style_key = nil,                             -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
		toggle_style_list = { 'vulgaris', 'multiplex', 'light' }, -- List of styles to toggle between
		transparent = false,                                -- Show/hide background
		dim_inactive = false,                               -- Dim inactive windows/buffers
		term_colors = true,                                 -- Change terminal color as per the selected theme style
		ending_tildes = false,                              -- Show the end-of-buffer tildes. By default they are hidden
		cmp_itemkind_reverse = false,                       -- reverse item kind highlights in cmp menu

		-- Change code style ---
		-- Options are italic, bold, underline, none
		-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
		code_style = {
			comments = 'italic',
			conditionals = 'italic',
			keywords = 'none',
			functions = 'none',
			namespaces = 'italic',
			parameters = 'italic',
			strings = 'none',
			variables = 'none',
		},

		-- Lualine options --
		lualine = {
			transparent = false, -- lualine center bar transparency
		},

		-- Custom Highlights --
		colors = {}, -- Override default colors
		highlights = {}, -- Override highlight groups

		-- Plugins Config --
		diagnostics = {
			darker = false, -- darker colors for diagnostic
			undercurl = true, -- use undercurl instead of underline for diagnostics
			background = true, -- use background color for virtual text
		},
	}
	require('bamboo').load()
	-- vim.cmd('colorscheme ' .. mxvim.current_theme)
end

M.colors = function()
	return {
		fg = '#f1e9d2',       -- light text color
		bg = '#252623',       -- background color
		light_fg = '#252623', -- text color
		light_bg = '#f1e9d2', -- light background color

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