local M = {}
local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 60

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local icons = {
	Text = " ",
	Method = " ",
	Function = " ",
	Constructor = "⌘ ",
	Field = "ﰠ ",
	Variable = " ",
	Class = "ﴯ ",
	Interface = " ",
	Module = " ",
	Property = "ﰠ ",
	Unit = "塞",
	Value = " ",
	Enum = " ",
	Keyword = "廓",
	Snippet = " ",
	Color = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = " ",
	Struct = "פּ ",
	Event = " ",
	Operator = " ",
	TypeParameter = "",
}

M.setup = function()
	if mxvim.use_cmp == false then
		return
	end
	vim.defer_fn(function()
		vim.cmd([[
        " PackerLoad lspkind-nvim
        PackerLoad nvim-cmp
        " Jump forward or backward
        " imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        " smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        " imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        " smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
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
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = {
			["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
			["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
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
						vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true),
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
						vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true),
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
			keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
			keyword_length = 1,
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(_, vim_item)
				vim_item.menu = vim_item.kind
				-- vim_item.kind = string.format("%s ", icons[vim_item.kind])
                vim_item.kind = icons[vim_item.kind]
				local label = vim_item.abbr
				-- local trim_label = label:gsub("^%s*(.-)%s*$", "%1")
				local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
				if truncated_label ~= label then
					label = truncated_label .. ELLIPSIS_CHAR
				end
				vim_item.abbr = label
				return vim_item
			end,
			-- format = require("lspkind").cmp_format({
			-- maxwidth = MAX_LABEL_WIDTH,
			-- 	before = function(_, vim_item)
			-- 		return vim_item
			-- 	end,
			-- 	with_text = true,
			-- 	menu = {
			-- 		vsnip = "[Snip]",
			-- 		nvim_lsp = "[LSP]",
			-- 		nvim_lua = "[Lua]",
			-- 		buffer = "[Buffer]",
			-- 		path = "[Path]",
			-- 	},
			-- }),
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
