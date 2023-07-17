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

	Flash.jump({
		jump = {
			autojump = true,
		},
		label = {
			after = true,
			before = false,
			style = "overlay",
			rainbow = {
				enabled = true,
				shade = 5,
			}

		}
	})
end
return M