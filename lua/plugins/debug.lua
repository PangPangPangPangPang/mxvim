return {
	-- debugger
	{
		"ravenxrz/nvim-dap",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"ravenxrz/DAPInstall.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-telescope/telescope-dap.nvim",
		},
	},


}