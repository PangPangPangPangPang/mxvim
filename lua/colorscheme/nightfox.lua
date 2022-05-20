local M = {}
M.setup = function()
	vim.cmd([[ PackerLoad nightfox.nvim]])
end
M.config = function()
	require("nightfox").setup({
		options = {
			-- Compiled file's destination location
			compile_path = vim.fn.stdpath("cache") .. "/nightfox",
			compile_file_suffix = "_compiled", -- Compiled file suffix
			transparent = false, -- Disable setting background
			terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
			dim_inactive = false, -- Non focused panes set to alternative background
			styles = { -- Style to be applied to different syntax groups
				comments = "italic",
				keywords = "bold",
				types = "italic,bold",
			},
			inverse = { -- Inverse highlight for different types
				match_paren = false,
				visual = false,
				search = false,
			},
			modules = { -- List of various plugins and additional options
				-- ...
			},
		},
	})
    -- nordfox nightfox dayfox dawnfox duskfox
	vim.cmd("colorscheme " .. "nightfox")
end

M.colors = function()
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
		blue = "#7FB4CA",
		red = "#FF5D62",
	}
end
return M
