if !Installed("nvim-treesitter")
    finish
endif
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

if has('nvim-0.5')
    " highlight link TSVariable None
    highlight link TSError None
    highlight link TSPunctBracket None
    let g:ts_ft_set = ['go', 'java', 'rust', 'javascript', 'typescript', 'lua', 'dart', 'typescriptreact']

    " augroup TSHighlight
    "     autocmd!
    "     autocmd CursorHold,CursorHoldI * call <SID>refresh_ts()
    "     autocmd VimEnter * call <SID>enable_ts_hl()
    " augroup END

    function s:refresh_ts() abort
        if exists('b:ts_last_changedtick') &&
                    \ (b:ts_last_changedtick < 0 || b:ts_last_changedtick == b:changedtick)
            return
        endif
        let ft = &filetype
        if index(g:ts_ft_set, ft) >= 0
            execute 'silent! TSBufDisable highlight'
            execute 'TSBufEnable highlight'
        else
            let b:ts_last_changedtick = -1
            return
        endif
        let b:ts_last_changedtick = b:changedtick
    endfunction

    function s:enable_ts_hl() abort
        lua require'nvim-treesitter.configs'.setup {
                    \   ensure_installed = vim.g.ts_ft_set,
                    \   highlight = {
                    \       enable = true,
                    \       disable = {'c'},
                    \   },
                    \ }
    endfunction
    lua require("treesitter")
endif
