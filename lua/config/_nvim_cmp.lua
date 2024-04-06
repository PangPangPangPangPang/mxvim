local M = {}
local MAX_LABEL_WIDTH = 60

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.config = function()
	local cmp = require("cmp")
	local window = {
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:Normal,FloatBorder:VertSplit,CursorLine:Visual,Search:None",
			-- col_offset = -4,
			side_padding = 1,
		}),
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:Normal,FloatBorder:VertSplit,CursorLine:Visual,Search:None",
		}),
	}
	cmp.setup({
		view = {
			entries = {
				follow_cursor = true,
			},
		},
		sorting = {
			priority_weight = 1.0,
			comparators = {
				cmp.config.compare.locality,
				-- cmp.config.compare.rencently_used,
				cmp.config.compare.score,
				cmp.config.compare.offset,
				cmp.config.compare.order,
			},
		},
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		experimental = {
			ghost_text = mxvim.enable_codeium ~= true and { hl_group = "Comment" } or false,
		},
		window = window,
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				local kind = require("lspkind").cmp_format({
					mode = "symbol",
					preset = "codicons",
					maxwidth = MAX_LABEL_WIDTH,
					symbol_map = { Codeium = "" },
				})(entry, vim_item)
				kind.kind = kind.kind .. " "
				return kind
			end,
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
				if vim.fn["vsnip#available"](1) == 1 then
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
				if vim.fn["vsnip#jumpable"](-1) == 1 then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "", true)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-up>"] = cmp.mapping.scroll_docs(-4),
			["<S-down>"] = cmp.mapping.scroll_docs(4),
		},
		-- You should specify your *installed* sources.
		sources = cmp.config.sources({
			{ name = "codeium",  priority = 9 },
			{ name = "vsnip",    priority = 8 },
			{ name = "nvim_lsp", priority = 7 },
			{ name = "path",     priority = 4 },
		}, {
			{ name = "buffer", priority = 6 },
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

M.hl_cmp = function(shade_colors)
	local colors = require("theme").colors()
	vim.cmd(string.format("hi! CmpItemAbbrMatch gui=bold guifg=%s", colors.blue))
	vim.cmd(string.format("hi! CmpItemAbbrMatchFuzzy gui=bold guifg=%s", colors.blue))
	vim.cmd(string.format("hi! CmpItemMenu gui=bold guifg=%s", shade_colors.fg))
	vim.cmd(string.format("hi! markdownBoldItalic gui=bold,italic guifg=%s", colors.blue))
	vim.cmd(string.format("hi! Cursor gui=bold guibg=%s guifg=%s", colors.fg, colors.bg))

	local bg = "bg"
	local fg = "fg"
	local hi = "NONE"

	vim.cmd(string.format("highlight! CmpItemKindField gui%s=%s gui%s=%s", bg, hi, fg, colors.yellow))
	vim.cmd(string.format("highlight! CmpItemKindProperty gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
	vim.cmd(string.format("highlight! CmpItemKindEvent gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))
	vim.cmd(string.format("highlight! CmpItemKindText gui%s=%s gui%s=%s", bg, hi, fg, colors.magenta))
	vim.cmd(string.format("highlight! CmpItemKindEnum gui%s=%s gui%s=%s", bg, hi, fg, colors.red))
	vim.cmd(string.format("highlight! CmpItemKindKeyword gui%s=%s gui%s=%s", bg, hi, fg, colors.green))
	vim.cmd(string.format("highlight! CmpItemKindConstant gui%s=%s gui%s=%s", bg, hi, fg, colors.yellow))
	vim.cmd(string.format("highlight! CmpItemKindConstructor gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
	vim.cmd(string.format("highlight! CmpItemKindReference gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))
	vim.cmd(string.format("highlight! CmpItemKindFunction gui%s=%s gui%s=%s", bg, hi, fg, colors.magenta))
	vim.cmd(string.format("highlight! CmpItemKindStruct gui%s=%s gui%s=%s", bg, hi, fg, colors.red))
	vim.cmd(string.format("highlight! CmpItemKindClass gui%s=%s gui%s=%s", bg, hi, fg, colors.green))
	vim.cmd(string.format("highlight! CmpItemKindModule gui%s=%s gui%s=%s", bg, hi, fg, colors.yellow))
	vim.cmd(string.format("highlight! CmpItemKindOperator gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
	vim.cmd(string.format("highlight! CmpItemKindVariable gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))
	vim.cmd(string.format("highlight! CmpItemKindFile gui%s=%s gui%s=%s", bg, hi, fg, colors.magenta))
	vim.cmd(string.format("highlight! CmpItemKindUnit gui%s=%s gui%s=%s", bg, hi, fg, colors.red))
	vim.cmd(string.format("highlight! CmpItemKindSnippet gui%s=%s gui%s=%s", bg, hi, fg, colors.green))
	vim.cmd(string.format("highlight! CmpItemKindFolder gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
	vim.cmd(string.format("highlight! CmpItemKindMethod gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))
	vim.cmd(string.format("highlight! CmpItemKindValue gui%s=%s gui%s=%s", bg, hi, fg, colors.magenta))
	vim.cmd(string.format("highlight! CmpItemKindEnumMember gui%s=%s gui%s=%s", bg, hi, fg, colors.red))
	vim.cmd(string.format("highlight! CmpItemKindInterface gui%s=%s gui%s=%s", bg, hi, fg, colors.green))
	vim.cmd(string.format("highlight! CmpItemKindColor gui%s=%s gui%s=%s", bg, hi, fg, colors.orange))
	vim.cmd(string.format("highlight! CmpItemKindTypeParameter gui%s=%s gui%s=%s", bg, hi, fg, colors.darkblue))
end
return M