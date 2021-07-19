local actions = require('telescope.actions')
local map = require('utils').map

map('n', '<c-p>', ':Telescope find_files<cr>', {silent = true})
map('n', '<leader>b', ':Telescope buffers theme=get_cursor<cr>', {silent = true})
map('n', '<leader>f', ':Telescope live_grep theme=get_dropdown<cr>', {silent = true})

require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        mappings = {
            i = {
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                ["<c-x>"] = false,

                -- Otherwise, just set the mapping to the function that you want it to be.
                ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center,

                -- You can perform as many actions in a row as you like
                ["<esc>"] = actions.close,
            },
            n = {
                ["<esc>"] = false,
                -- ["<C-i>"] = my_cool_custom_action,
            },
        },
        prompt_prefix = "❤  ",
        selection_caret = "▶ ",
        entry_prefix = "  ",
        initial_mode = "insert",
        -- selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
            horizontal = {
                mirror = false,
                prompt_position = "top",
                width = 0.75,
                preview_cutoff = 120,
            },
            vertical = {
                mirror = true,
                width = 0.50,
            },
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        path_display = {'absolute'},
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }

}
