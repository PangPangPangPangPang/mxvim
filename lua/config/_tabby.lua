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
    local line = require("tabby.presets").active_wins_at_tail
    local label = function(tabid)
        return {
            '  ' .. fn.getcwd(-1, tabid) .. ' ',
            hl = 'Substitute',
        }
    end
    line.active_tab.label = label
    local inactive_label = function(tabid)
        return {
            '  ' .. fn.getcwd(-1, tabid) .. ' ',
            hl = 'TabLine',
        }
    end
    line.inactive_tab.label = inactive_label
    require("tabby").setup({
        tabline = line
    })
    o.showtabline = 1
end
return M
