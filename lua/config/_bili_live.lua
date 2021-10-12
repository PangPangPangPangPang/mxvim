local M = {}
M.config = function()
	require("bilibili_live_broadcast").setup({
		handler = function(msg)
			if msg.type ~= "INTERACT_WORD" then
				require("notify")(
					msg.msg,
					"info",
					{ title = require("bilibili_live_broadcast.utils").actions[msg.type] }
				)
			end
		end,
	})
end

return M
