-- compe
--[[ buf_set_keymap('i', '<CR>', "<cmd>lua compe#confirm('<CR>')", opts)
buf_set_keymap('i', '<c-e>', "<cmd>lua compe#confirm('<c-e>')", opts)
buf_set_keymap('i', '<c-n>', "<cmd>lua compe#scroll({ 'delta': +1 })", opts)
buf_set_keymap('i', '<c-p>', "<cmd>lua compe#scroll({ 'delta': -1 })", opts) ]]
-- require'compe'.setup {
--     enabled = true;
--     autocomplete = true;
--     debug = false;
--     min_length = 1;
--     -- preselect = 'enable';
--     preselect = 'always';
--     throttle_time = 80;
--     source_timeout = 200;
--     incomplete_delay = 400;
--     max_abbr_width = 100;
--     max_kind_width = 100;
--     max_menu_width = 100;
--     documentation = true;

--     source = {
--         vsnip = true;
--         ultisnips = true;
--         nvim_lsp = true;
--         nvim_lua = true;
--         path = true;
--         buffer = true;
--         calc = true;
--     };
-- }
local M = {}

M.config = function()
    require "compe".setup {
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
            path = true;
            buffer = {kind = "﬘", true},
            calc = true;
        }
    }
end

M.snippets = function()
    local ls = require("luasnip")

    ls.config.set_config(
        {
            history = true,
            updateevents = "TextChanged,TextChangedI"
        }
    )
    require("luasnip/loaders/from_vscode").load()
end

return M
