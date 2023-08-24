local M = {}
M.config = function()
    local map = require("utils").map
    -- map("n", "<c-p>", "<cmd>lua findFiles()<cr>", { silent = true })
    map("n", "<leader>b", ":Telescope buffers<cr>", { silent = true })
    map("n", "<leader>f", ":Telescope live_grep<cr>", { silent = true })
    -- vim.cmd([[
    -- xnoremap<silent> <leader>f :<c-u>execute 'Telescope live_grep default_text=' . GetVisualSelection(visualmode())<cr>
    -- command! -nargs=0 LS :Telescope buffers
    -- cnoreabbrev ls LS
    -- ]])
    local actions = require("telescope.actions")
    require("telescope").setup({
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            mappings = {
                i = {
                    -- To disable a keymap, put [map] = false
                    -- So, to not map "<C-n>", just put
                    ["<c-x>"] = false,
                    -- Otherwise, just set the mapping to the function that you want it to be.
                    ["<c-i>"] = actions.select_horizontal,

                    -- You can perform as many actions in a row as you like
                    ["<esc>"] = actions.close,
                    ["<C-l>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<c-c>"] = { "<esc>", type = "command" },
                },
                n = {
                    ["<esc>"] = actions.close,
                    ["<c-c>"] = false,
                    ["<c-l>"] = actions.send_to_qflist + actions.open_qflist,
                },
            },
            path_display = { "truncate" },
            prompt_prefix = "   ",
            selection_caret = " ▶ ",
            entry_prefix = "  ",
            initial_mode = "insert",
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
                    prompt_position = "top",
                },
            },
            -- file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = {},
            -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            winblend = 10,
            border = {},
            borderchars = {
                "─",
                "│",
                "─",
                "│",
                "╭",
                "╮",
                "╯",
                "╰",
            },
            color_devicons = true,
            -- use_less = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    })
    require("telescope").load_extension("fzf")
end

local zfvim = require("config._zfvimim")

---@diagnostic disable-next-line: lowercase-global
function findFiles()
    if zfvim.is_zf_load then
        stop_zfvimim(0)
    end
    vim.cmd(
        "Telescope find_files"
    )
end

return M