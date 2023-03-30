local M = {}
local MAX_LABEL_WIDTH = 60

local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.config = function()
        local cmp = require("cmp")
        cmp.setup({
                snippet = {
                        expand = function(args)
                                vim.fn["vsnip#anonymous"](args.body)
                        end,
                },
                experimental = {
                        ghost_text = { hl_group = "Comment" },
                },
                -- preselect = cmp.PreselectMode.None,
                -- You can set mapping if you want.
                window = {
                        -- completion = {
                        -- 	winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        -- 	col_offset = -3,
                        -- 	side_padding = 0,
                        -- },
                        completion = cmp.config.window.bordered({
                                -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                                winhighlight = "Normal:Normal,FloatBorder:VertSplit,CursorLine:Visual,Search:None",
                                col_offset = -4,
                                side_padding = 1,
                        }),
                        documentation = cmp.config.window.bordered({
                                winhighlight = "Normal:Normal,FloatBorder:VertSplit,CursorLine:Visual,Search:None",
                        }),
                },
                formatting = {
                        fields = { "kind", "abbr", "menu" },
                        format = function(entry, vim_item)
                                local kind = require("lspkind").cmp_format({ mode = "symbol", maxwidth = MAX_LABEL_WIDTH })(
                                        entry,
                                        vim_item
                                )
                                -- local strings = vim.split(kind.kind, "%s", { trimempty = true })
                                kind.kind = kind.kind .. " "
                                -- kind.menu = "    (" .. strings[2] .. ")"
                                return kind
                        end,
                },

                mapping = {
                        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                                { "i" }),
                        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                                { "i" }),
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ["<CR>"] = cmp.mapping(
                                cmp.mapping.confirm({
                                        behavior = cmp.ConfirmBehavior.Replace,
                                        select = true,
                                }),
                                { "i" }
                        ),
                        ["<Tab>"] = cmp.mapping(function(fallback)
                                if cmp.visible() then
                                        cmp.select_next_item()
                                elseif vim.fn["vsnip#available"](1) == 1 then
                                        vim.api.nvim_feedkeys(
                                                vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true
                                                        , true),
                                                "",
                                                true
                                        )
                                elseif has_words_before() then
                                        cmp.complete()
                                else
                                        fallback()
                                end
                        end, {
                                "i",
                                "s",
                        }),
                        ["<S-Tab>"] = cmp.mapping(function(fallback)
                                if cmp.visible() then
                                        cmp.select_prev_item()
                                elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                                        vim.api.nvim_feedkeys(
                                                vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true,
                                                        true),
                                                "",
                                                true
                                        )
                                else
                                        fallback()
                                end
                        end, {
                                "i",
                                "s",
                        }),
                        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        -- ["<C-e>"] = cmp.mapping.close(),
                },
                -- You should specify your *installed* sources.
                sources = cmp.config.sources({
                        { name = "vsnip" },
                        { name = "nvim_lsp" },
                        -- { name = "tags" },
                        { name = "nvim_lua" },
                        -- { name = "buffer" },
                        { name = "path" },
                        { name = "nvim_lsp_signature_help" },
                }, {
                        { name = 'buffer' },
                }),
                completion = {
                        completeopt = "menu,menuone,noinsert",
                        keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
                        keyword_length = 1,
                },
        })

        cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                completion = {
                        completeopt = "menu,menuone,noinsert,noselect",
                        keyword_length = 1,
                },
                sources = cmp.config.sources({
                        { name = "nvim_lsp_document_symbol" },
                }, {
                        { name = "buffer" },
                }),
        })

        -- Use cmdline & path source for ':'.
        cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                completion = {
                        completeopt = "menu,menuone,noinsert,noselect",
                        keyword_length = 1,
                },
                sources = cmp.config.sources({
                        { name = "path" },
                }, {
                        { name = "cmdline" },
                }),
        })
end
return M
