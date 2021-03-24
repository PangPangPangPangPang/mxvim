if Installed("telescope.nvim")
    noremap <silent><c-p> :Telescope find_files<cr>
    noremap <silent><leader>b :Telescope buffers<cr>
    lua require("_telescope")
endif
