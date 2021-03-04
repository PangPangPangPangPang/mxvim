if !Installed("telescope.nvim")
    finish
endif
lua require("_telescope")
