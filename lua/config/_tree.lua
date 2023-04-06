local M = {}
local g = vim.g
M.init = function()
    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
end
M.config = function()
    local function on_attach(bufnr)
        local api = require('nvim-tree.api')

        local function generate_cb_string(callback_name)
            return string.format("lua require'nvim-tree.api'.%s()", callback_name)
        end

        ---@diagnostic disable-next-line: lowercase-global
        function open_luatree()
            local content = {
                { "Copy File             &c", generate_cb_string("fs.copy.node") },
                { "Paste file            &p", generate_cb_string("fs.paste") },
                { "Rename file           &r", generate_cb_string("fs.rename") },
                { "Move file             &m", generate_cb_string("fs.cut") },
                { "Delete file           &d", generate_cb_string("fs.remove") },
                { "New Files             &n", generate_cb_string("fs.create") },
                { "Yank Path             &y", generate_cb_string("fs.copy.absolute_path") },
                { "Toggle ignored files  &.", generate_cb_string("tree.toggle_gitignore_filter") },
                { "Go back               &u", generate_cb_string("tree.change_root_to_parent") },
                { "Go Root               &R", "cd getcwd()" },
                { "System Open           &s", generate_cb_string("node.run.system") },
            }
            local opts = { title = "menu", ignore_case = 0 }
            vim.call("quickui#context#open", content, opts)
        end

        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', '<Tab>', ":lua open_luatree()<cr>", { buffer = bufnr }, opts('Open menu'))
    end

    require("nvim-tree").setup({
        on_attach = on_attach,
        disable_netrw = true,
        hijack_netrw = true,
        ignore_ft_on_setup = {},
        -- auto_close = false,
        open_on_tab = true,
        hijack_cursor = true,
        update_cwd = true,
        diagnostics = {
            enable = false,
        },
        renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = false,
            highlight_opened_files = "none",
            root_folder_modifier = ":~",
            indent_markers = {
                enable = false,
            },
        },
        update_focused_file = {
            enable = true,
            update_cwd = false,
            ignore_list = { "node_modules", ".git", "build" },
        },
        system_open = {
            cmd = nil,
            args = {},
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = true,
                window_picker = {
                    enable = false,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
        },
        view = {
            hide_root_folder = true,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            width = "15%",
        },
    })
    vim.cmd([[
                hi! link NvimTreeStatusLineNC NvimTreeNormal
            ]])
    vim.cmd(string.format("hi! NvimTreeStatusLine cterm=bold,reverse guibg=%s",
        require("theme").extract_nvim_hl("NvimTreeNormal").bg))
end

---@diagnostic disable-next-line: lowercase-global
function open_nvim_tree(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
        return
    end
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
end

M.theme = function()
    local colors = require("theme").theme_colors()
    local root_name = string.format("hi! NvimTreeRootFolder guifg=%s gui=bold", colors.yellow)
    local folder_name = string.format("hi! NvimTreeFolderName guifg=%s gui=bold", colors.blue)
    local opened_folder_name = string.format("hi! NvimTreeOpenedFolderName guifg=%s gui=bold", colors.blue)
    local empty_folder_foldername = string.format("hi! NvimTreeEmptyFolderName guifg=%s gui=bold", colors.blue)
    vim.cmd(string.format(
        [[
        augroup NvimTree
            %s
            %s
            %s
            %s
        augroup End
    ]]   ,
        root_name,
        folder_name,
        opened_folder_name,
        empty_folder_foldername
    ))
end

return M
