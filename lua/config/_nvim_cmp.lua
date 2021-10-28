local M = {}

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
	local lspkind = require("lspkind")
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		experimental = {
			native_menu = false,
			ghost_text = { hl_group = "Comment" },
		},
		-- preselect = cmp.PreselectMode.None,
		-- You can set mapping if you want.
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-Space>"] = cmp.mapping.complete(),
			-- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
			-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
			-- ["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
		},
		-- You should specify your *installed* sources.
		sources = {
			{ name = "vsnip" },
			{ name = "nvim_lsp" },
			-- { name = "tags" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "path" },
		},
		completion = {
			completeopt = "menu,menuone,noinsert",
			keyword_length = 1,
		},
		formatting = {
			format = require("lspkind").cmp_format({
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
	-- Use buffer source for `/`.
	cmp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':'.
	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end
return M
