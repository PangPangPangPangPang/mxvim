local M = {}

M.config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    cmp.setup {
        snippet = {
            expand = function(args)
                require'luasnip'.lsp_expand(args.body)
            end
        },
        -- You can set mapping if you want.
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            })
        },
        -- You should specify your *installed* sources.
        sources = {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'buffer' },
            { name = 'path' },
        },
        completion = {
            completeopt = 'menu,menuone,noinsert',
            keyword_length = 1,
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[Latex]",
                })[entry.source.name]
                return vim_item
            end
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
