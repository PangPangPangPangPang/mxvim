local map = require('utils').map
local M = {}

M.config = function()
    vim.o.completeopt = "menuone,noselect"
    local opts = {noremap = true, silent = true, expr = true}
    map('i', '<C-Space>', "compe#complete()", opts)
    map('i', '<CR>', "compe#confirm('<CR>')", opts)
    map('i', '<C-e>', "compe#close('<C-e>')", opts)
    -- map('i', '<C-f>', "compe#scroll({ 'delta': +4 })", opts)
    -- map('i', '<C-d>', "compe#scroll({ 'delta': -4 })", opts)
    require"compe".setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = "always",
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,
        source = {
            luasnip = {kind = "﬌", true},
            nvim_lsp = true,
            nvim_lua = true,
            path = true,
            buffer = {kind = "﬘", true},
            calc = true
        }
    }
end

M.snippets = function()
    local ls = require("luasnip")

    ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI"
    })
    require("luasnip/loaders/from_vscode").load()
end

return M
