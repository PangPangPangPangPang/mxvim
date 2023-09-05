local M = {}
M.config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 'cl', '<Plug>(leap-forward-to)')
    vim.keymap.set({ 'n', 'x', 'o' }, 'cc', '<Plug>(leap-backforward-to)')
    local colors = require("theme").colors()
    vim.cmd(string.format("hi! LeapMatch gui=bold guibg=%s guifg=%s", colors.red, colors.bg))
    vim.cmd(string.format("hi! LeapLabelPrimary gui=bold guibg=%s guifg=%s", colors.green, colors.bg))
    vim.cmd(string.format("hi! LeapLabelSecondary gui=bold guibg=%s guifg=%s", colors.blue, colors.bg))
    vim.cmd(string.format("hi! LeapLabelSelected guibg=%s guifg=%s", colors.purple, colors.sbg))
    require("leap").ops = {
        max_phase_one_targets = 0,
        highlight_unlabeled_phase_one_targets = false,
        max_highlighted_traversal_targets = 10,
        case_sensitive = false,
        equivalence_classes = { ' \t\r\n', },
        substitute_chars = {},
        special_keys = {
            repeat_search = '<enter>',
            next_phase_one_target = '<enter>',
            next_target = { '<enter>', ';' },
            prev_target = { '<tab>', ',' },
            next_group = '<space>',
            prev_group = '<tab>',
            multi_accept = '<enter>',
            multi_revert = '<backspace>',
        }
    }
end
return M