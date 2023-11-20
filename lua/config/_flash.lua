local M = {}
local Flash = require("flash")
M.jump = function()
	local function format(opts)
		-- always show first and second label
		return {
			{ opts.match.label1, "FlashMatch" },
			{ opts.match.label2, "FlashLabel" },
		}
	end

	local colors = require("theme").colors()
	vim.api.nvim_set_hl(0, "FlashLabel", { bold = true, fg = colors.bg, bg = colors.red })
	Flash.jump({
		jump = {
			autojump = true,
		},
		label = {
			after = true,
			before = false,
			style = "overlay",
			rainbow = {
				enabled = false,
				shade = 5,
			}
		},
	})
end
return M