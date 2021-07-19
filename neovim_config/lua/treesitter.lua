require'nvim-treesitter.configs'.setup {
    -- npm i -g tree-sitter-cli
    -- ensure_installed = 'maintained',     -- one of "all", "language", or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
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
    indent = {
        enable = false
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
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
    },
    rainbow = {
        colors = {
            '#4EC9B0',
            '#6A9955',
            '#CE9178',
            '#C586C0',
            '#C586C0',
            '#569CD6',
            '#F44747'
        },
        enable = true
    }

}

vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<leader>/", "gcc", {})
vim.api.nvim_set_keymap("v", "<leader>/", "gc", {})
