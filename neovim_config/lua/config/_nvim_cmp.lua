local M = {}

M.setup = function()
    vim.defer_fn(function ()
        vim.cmd([[ 
            PackerLoad lspkind-nvim
            PackerLoad nvim-cmp
        ]])
    end, 1000)
end

M.config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
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
            -- ['<CR>'] = cmp.mapping.confirm({
            --     behavior = cmp.ConfirmBehavior.Insert,
            --     select = true,
            -- })
        },
        -- You should specify your *installed* sources.
        sources = {
            { name = 'vsnip' },
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
                    nvim_lsp = "[LSP]",
                    vsnip = "[Snip]",
                    nvim_lua = "[Lua]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end
  }
    }
end
return M
