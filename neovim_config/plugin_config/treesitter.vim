if !Installed("nvim-treesitter")
    finish
endif
nnoremap <silent> <leader>ts :execute('silent! TSBufDisable highlight') <bar>
                \ execute('TSBufEnable highlight') <CR>
" autocmd InsertLeave * execute('silent! write | edit | TSBufEnable highlight')

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

if has('nvim-0.5')
    " highlight link TSVariable None
    highlight link TSError None
    highlight link TSPunctBracket None
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",     -- one of "all", "language", or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { "c", "rust" },  -- list of language that will be disabled
        custom_captures = {
            -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
            ["foo.bar"] = "None",
        },
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    refactor = {
        highlight_definitions = { enable = false },
        highlight_current_scope = { enable = false },
        smart_rename = {
            enable = false,
            keymaps = {
                smart_rename = "grr",
            },
        },
        navigation = {
            enable = false,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
            },
        },
    },
    textobjects = {
        move = {
            enable = false,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = false,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
        select = {
            enable = false,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                -- Or you can define your own textobjects like this
                ["iF"] = {
                    python = "(function_definition) @function",
                    cpp = "(function_definition) @function",
                    c = "(function_definition) @function",
                    java = "(method_declaration) @function",
                },
            },
        },
    },
}
EOF
endif
