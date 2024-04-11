local M = {}
M.config = function()
  require("modus-themes").setup({
    -- Theme comes in two styles `modus_operandi` and `modus_vivendi`
    -- `auto` will automatically set style based on background set with vim.o.background
    style = "auto",
    variant = "tinted", -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
    transparent = false, -- Transparent background (as supported by the terminal)
    dim_inactive = false, -- "non-current" windows are dimmed
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
    },

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
  })
  vim.cmd("colorscheme " .. mxvim.current_theme)
end

M.colors = function()
	return {
		fg = '#fbf7f0',       -- light text color
		bg = '#0D0E1C',       -- background color
		light_fg = '#0D0E1C', -- text color
		light_bg = '#fbf7f0', -- light background color

		yellow = '#6f5500',
		cyan = '#005e8b',
		darkblue = '#003497',
		green = '#006800',
		orange = '#80601f',
		purple = '#7b435c',
		magenta = '#721045',
		blue = '#0031a9',
		red = '#a60000',
		line_fg = '#252623',
	}
end
return M