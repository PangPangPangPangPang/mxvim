local fn = vim.fn
local o = vim.o
local M = {}
M.setup = function()
    vim.defer_fn(function ()
        vim.cmd([[
        PackerLoad tabby.nvim
        ]])
    end, 1500)
end
M.config = function ()
    local util = require('tabby.util')
    local hl_tabline_sel = util.extract_nvim_hl('TabLineSel')
    local hl_tabline = util.extract_nvim_hl('TabLine')

    local line = require("tabby.presets").active_wins_at_tail
    local label = function(tabid)
        return {
            '  ' .. fn.getcwd(-1, tabid) .. ' ',
            hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = 'bold' },
        }
    end
    line.active_tab.label = label
    local inactive_label = function(tabid)
        return {
            '  ' .. fn.getcwd(-1, tabid) .. ' ',
            hl = { fg = hl_tabline.fg, bg = hl_tabline.bg, style = 'bold' },
        }
    end
    line.inactive_tab.label = inactive_label
    require("tabby").setup({
        tabline = line
    })
    o.showtabline = 1
end
return M
