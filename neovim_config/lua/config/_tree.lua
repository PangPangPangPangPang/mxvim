local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local map = require('utils').map
map({'n', 'i'}, '<F1>', ":NvimTreeToggle<CR>", {silent = true})
map({'n'}, '<leader>j', ":NvimTreeFindFile<CR>", {silent = true})

local function generate_cb_string(callback_name)
    return string.format("lua require'nvim-tree'.on_keypress('%s')",
                         callback_name)
end

function open_luatree()
    local content = {
        {"Copy File             &c", generate_cb_string('copy')},
        {"Paste file            &p", generate_cb_string('paste')},
        {"Rename file           &r", generate_cb_string('rename')},
        {"Move file             &m", generate_cb_string('cut')},
        {"Delete file           &d", generate_cb_string('remove')},
        {"New Files             &n", generate_cb_string('create')},
        {"Yank Path             &y", generate_cb_string('copy_path')},
        {"Toggle ignored files  &.", generate_cb_string('toggle_dotfiles')},
        {"Go back               &u", generate_cb_string('dir_up')},
        {"Go Root               &R", "cd getcwd()"},
        {"System Open           &s", generate_cb_string('system_open')}
    }
    local opts = {title = "menu", ignore_case = 0}
    vim.call("quickui#context#open", content, opts)
end
vim.g.nvim_tree_bindings = {
    {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
    {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
    {key = "v", cb = tree_cb("vsplit")},
    {key = "s", cb = tree_cb("split")},
    {key = "<C-t>", cb = tree_cb("tabnew")},
    {key = "<", cb = tree_cb("prev_sibling")},
    {key = ">", cb = tree_cb("next_sibling")},
    {key = "P", cb = tree_cb("parent_node")},
    {key = "<BS>", cb = tree_cb("close_node")},
    {key = "<S-CR>", cb = tree_cb("close_node")},
    {key = "p", cb = tree_cb("preview")},
    {key = "<Tab>", cb = ":lua open_luatree()<cr>"},
    {key = "K", cb = tree_cb("first_sibling")},
    {key = "J", cb = tree_cb("last_sibling")},
    -- { key = ".",                            cb = tree_cb("toggle_ignored") },
    {key = ".", cb = tree_cb("toggle_dotfiles")},
    {key = "R", cb = tree_cb("refresh")}, {key = "a", cb = tree_cb("create")},
    {key = "d", cb = tree_cb("remove")}, {key = "r", cb = tree_cb("rename")},
    {key = "<C-r>", cb = tree_cb("full_rename")},
    {key = "x", cb = tree_cb("cut")}, {key = "c", cb = tree_cb("copy")},
    {key = "p", cb = tree_cb("paste")}, {key = "y", cb = tree_cb("copy_name")},
    {key = "Y", cb = tree_cb("copy_path")},
    {key = "gy", cb = tree_cb("copy_absolute_path")},
    {key = "[c", cb = tree_cb("prev_git_item")},
    {key = "]c", cb = tree_cb("next_git_item")},
    {key = "u", cb = tree_cb("dir_up")}, {key = "q", cb = tree_cb("close")},
    {key = "g?", cb = tree_cb("toggle_help")}
}
vim.g.nvim_tree_width = 40
-- vim.g.nvim_tree_hijack_netrw = 0
-- vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_follow_update_path = 1
vim.g.nvim_tree_indent_markers = 1
-- vim.g.nvim_tree_highlight_opened_files = 1
-- vim.g.nvim_tree_root_folder_modifier = '❤  '
-- vim.g.nvim_tree_lsp_diagnostics = 1
