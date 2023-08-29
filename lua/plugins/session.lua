return {
	{
		'goolord/alpha-nvim',
		cmd = "Alpha",
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		init = function()
			if vim.fn.argc() == 0 then
				local alpha = require 'alpha'
				local dashboard = require 'alpha.themes.dashboard'
				dashboard.section.header.val = {
					[[_|      _|                                              _|    _|      _|            _|      _|  _|                ]],
					[[_|_|  _|_|    _|_|_|  _|    _|      _|      _|      _|      _|_|_|_|  _|_|_|        _|      _|      _|_|_|  _|_|  ]],
					[[_|  _|  _|  _|    _|    _|_|        _|      _|      _|  _|    _|      _|    _|      _|      _|  _|  _|    _|    _|]],
					[[_|      _|  _|    _|  _|    _|        _|  _|  _|  _|    _|    _|      _|    _|        _|  _|    _|  _|    _|    _|]],
					[[_|      _|    _|_|_|  _|    _|          _|      _|      _|      _|_|  _|    _|          _|      _|  _|    _|    _|]],
				}
				dashboard.section.buttons.val = {
					dashboard.button("<leader> S", "  Open Session", ":SessionManager load_session<CR>"),
					dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
				}
				local handle = io.popen('fortune')
				local fortune = handle:read("*a")
				handle:close()
				dashboard.section.footer.val = fortune

				dashboard.config.opts.noautocmd = true

				vim.cmd [[autocmd User AlphaReady echo 'ready']]

				alpha.setup(dashboard.config)
			end
		end,
	},
	{
		"Shatur/neovim-session-manager",
		cmd = { "SessionManager" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>s", "<cmd>SessionManager load_session<cr>", mode = "n" },
		},
	},
}