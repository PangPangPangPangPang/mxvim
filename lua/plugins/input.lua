if require("utils").system() == "MacOS"  and mxvim.enable_squirrel then
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
		enabled = require("utils").system() == "Linux" or not mxvim.enable_squirrel,
		event = "VeryLazy",
		config = function()
			require('im_select').setup({
            -- IM will be set to `default_im_select` in `normal` mode
            -- For Windows/WSL, default: "1033", aka: English US Keyboard
            -- For macOS, default: "com.apple.keylayout.ABC", aka: US
            -- For Linux, default:
            --               "keyboard-us" for Fcitx5
            --               "1" for Fcitx
            --               "xkb:us::eng" for ibus
            -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
            default_im_select  = "com.apple.keylayout.ABC",

						-- https://github.com/laishulu/macism
            default_command = 'macism',

            -- Restore the default input method state when the following events are triggered
            set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

            -- Restore the previous used input method state when the following events
            -- are triggered, if you don't want to restore previous used im in Insert mode,
            -- e.g. deprecated `disable_auto_restore = 1`, just let it empty
            -- as `set_previous_events = {}`
            set_previous_events = { "InsertEnter" },

            -- Show notification about how to install executable binary when binary missed
            keep_quiet_on_no_binary = false,

            -- Async run `default_command` to switch IM or not
            async_switch_im = true
        })
		end
	}
}