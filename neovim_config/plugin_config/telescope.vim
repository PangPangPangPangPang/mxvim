if !Installed("telescope.nvim")
    finish
endif
noremap <silent><c-p> :Telescope find_files<cr>
lua require("_telescope")
