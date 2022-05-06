local M = {}
local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 60

M.setup = function()
	if mxvim.use_cmp == false then
		return
	end
	vim.defer_fn(function()
		vim.cmd([[
        PackerLoad lspkind-nvim
        PackerLoad nvim-cmp
        " Jump forward or backward
        imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        " imap <expr> <c-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<c-j>'
        " smap <expr> <c-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<c-j>'
        " imap <expr> <c-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<c-k>'
        " smap <expr> <c-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<c-k>'
        ]])
	end, 400)
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
			-- completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = {
			["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
			["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
			["<C-Space>"] = cmp.mapping.complete(),
			-- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
			-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
			-- ["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping(
				cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				{ "i" }
			),
		},
		-- You should specify your *installed* sources.
		sources = {
			{ name = "vsnip" },
			{ name = "nvim_lsp" },
			-- { name = "tags" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "nvim_lsp_signature_help" },
		},
		completion = {
			completeopt = "menu,menuone,noinsert",
			keyword_length = 1,
		},
		formatting = {
			format = require("lspkind").cmp_format({
				before = function(_, vim_item)
					local label = vim_item.abbr
                    -- vim_item.abbr = label:gsub("^%s*(.-)%s*$", "%1")
					local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
					if truncated_label ~= label then
						vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
					end
                    return vim_item
				end,
				with_text = true,
				menu = {
					vsnip = "[Snip]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[Lua]",
					buffer = "[Buffer]",
					path = "[Path]",
				},
			}),
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
