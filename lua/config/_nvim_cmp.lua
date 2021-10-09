local M = {}

M.setup = function()
	vim.defer_fn(function()
		vim.cmd([[
            PackerLoad lspkind-nvim
            PackerLoad nvim-cmp
            " Jump forward or backward
            imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
            smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
            imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
            smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
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
        preselect = cmp.PreselectMode.None,
		-- You can set mapping if you want.
		mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			['<CR>'] = cmp.mapping.confirm({
			    behavior = cmp.ConfirmBehavior.Replace,
			    select = true,
			})
		},
		-- You should specify your *installed* sources.
		sources = {
			{ name = "vsnip" },
			{ name = "nvim_lsp" },
			{ name = "tags" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "path" },
		},
		completion = {
			completeopt = "menu,menuone,noinsert",
			keyword_length = 1,
		},
        formatting = {
            format = lspkind.cmp_format({with_text = true, maxwidth = 50})
        },
	})
end
return M
