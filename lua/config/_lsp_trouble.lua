local M = {}
M.config = function ()
    require("trouble").setup {
        auto_preview = false,
        auto_fold = true,
        action_keys = {
            jump = {"<tab>", "o"}, -- jump to the diagnostic or open / close folds
            jump_close = {"<cr>"}
        },
        use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }
end
return M
