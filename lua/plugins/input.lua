if require("utils").system() == "MacOS" then
	local squirrel = vim.fn.executable("/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel")
	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		callback = function()
			if squirrel then
				vim.fn.system([[
			/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --ascii_mode_prev
			]])
			end
		end
	})

	vim.api.nvim_create_autocmd({ "InsertLeave" }, {
		callback = function()
			if squirrel then
				vim.fn.system([[
			/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --ascii_mode
			]])
			end
		end
	})
end

return {
	{
		"ZSaberLv0/ZFVimIM",
		lazy = true,
		keys = {
			{ "<c-x>", "<cmd>lua toggle_zfvimim()<cr>",  mode = "n" },
			{ "<c-x>", "<c-o>:lua toggle_zfvimim()<cr>", mode = "i" },
		},
		dependencies = {
			"ZSaberLv0/ZFVimJob",
			"ZSaberLv0/ZFVimGitUtil",
			"PangPangPangPangPang/ZFVimIM_pinyin",
			"ZSaberLv0/ZFVimIM_openapi",
		},
		init = function()
			require("config._zfvimim").setup()
		end,
		config = function()
			require("config._zfvimim").config()
		end,
	},
	{
		"keaising/im-select.nvim",
		lazy = true,
		enabled = require("utils").system() == "Linux",
		event = "VeryLazy",
		config = function()
			require("im_select").setup({})
		end
	}
}