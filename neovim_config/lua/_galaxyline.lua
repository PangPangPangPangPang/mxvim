local gl = require('galaxyline')
local gls = gl.section
-- local extension = require('galaxyline.provider_extensions')

gl.short_line_list = {
    'LuaTree', 'vista', 'dbui', 'startify', 'term', 'nerdtree', 'fugitive',
    'fugitiveblame', 'plug', 'defx'
}

-- vscode
local colors = {
    -- bg = '#264F78',
    -- line_bg = '#264F78',
    bg = '#252526',
    line_bg = '#252526',
    fg = '#9CDCFE',
    fg_green = '#B5CEA8',

    yellow = '#DCDCAA',
    cyan = '#4EC9B0',
    darkblue = '#223E55',
    green = '#6A9955',
    orange = '#CE9178',
    purple = '#C586C0',
    magenta = '#C586C0',
    blue = '#569CD6',
    red = '#F44747'
}

-- miramire
-- colors = {
--     bg = '#2A0000',
--     -- line_bg = '#1E1E1E',
--     line_bg = '#2A0000',
--     fg = '#e6d6ac',
--     fg_green = '#87c095',

--     yellow = '#d9bb80',
--     cyan = '#87c095',
--     darkblue = '#203a41',
--     green = '#a7c080',
--     orange = '#e39b7b',
--     purple = '#d3a0bc',
--     magenta = '#d3a0bc',
--     blue = '#89beba';
--     red = '#e68183'
-- }
vim.api.nvim_command('hi! StatusLine guibg=' .. colors.line_bg .. ' guifg=' ..
                         colors.line_bg)
-- vim.api.nvim_command('hi! StatusLine guibg=#1E1E1E guifg=#1E1E1E')

local function lsp_status(status)
    shorter_stat = ''
    for match in string.gmatch(status, "[^%s]+") do
        err_warn = string.find(match, "^[WE]%d+", 0)
        if not err_warn then shorter_stat = shorter_stat .. ' ' .. match end
    end
    return shorter_stat
end

local function get_coc_lsp()
    local status = vim.fn['coc#status']()
    if not status or status == '' then return '' end
    return lsp_status(status)
end

function get_diagnostic_info()
    if vim.fn.exists('*coc#rpc#start_server') == 1 then return get_coc_lsp() end
    return ''
end

local function get_current_func()
    local has_func, func_name = pcall(vim.fn.nvim_buf_get_var, 0,
                                      'coc_current_function')
    if not has_func then return end
    return func_name
end

function get_function_info()
    if vim.fn.exists('*coc#rpc#start_server') == 1 then
        return get_current_func()
    end
    return ''
end

local function trailing_whitespace()
    local trail = vim.fn.search("\\s$", "nw")
    if trail ~= 0 then
        return ' '
    else
        return nil
    end
end

CocStatus = get_diagnostic_info
CocFunc = get_current_func
TrailingWhiteSpace = trailing_whitespace

function has_file_type()
    local f_type = vim.bo.filetype
    if not f_type or f_type == '' then return false end
    return true
end

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then return true end
    return false
end

gls.left[1] = {
    FirstElement = {
        provider = function() return ' ' end,
        highlight = {colors.blue, colors.line_bg}
    }
}
gls.left[2] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local alias = {
                n = 'NORMAL',
                i = 'INSERT',
                c = 'COMMAND',
                V = 'VISUAL',
                [''] = 'VISUAL',
                v = 'VISUAL',
                c = 'COMMAND-LINE',
                ['r?'] = ':CONFIRM',
                rm = '--MORE',
                R = 'REPLACE',
                Rv = 'VIRTUAL',
                s = 'SELECT',
                S = 'SELECT',
                ['r'] = 'HIT-ENTER',
                [''] = 'SELECT',
                t = 'TERMINAL',
                ['!'] = 'SHELL'
            }
            local mode_color = {
                n = colors.green,
                i = colors.blue,
                v = colors.magenta,
                [''] = colors.blue,
                V = colors.blue,
                c = colors.red,
                no = colors.magenta,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.purple,
                Rv = colors.purple,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.green,
                t = colors.green,
                c = colors.purple,
                ['r?'] = colors.red,
                ['r'] = colors.red,
                rm = colors.red,
                R = colors.yellow,
                Rv = colors.magenta
            }
            local vim_mode = vim.fn.mode()
            vim.api.nvim_command('hi GalaxyViMode guifg=' ..
                                     mode_color[vim_mode])
            return alias[vim_mode] .. '  '
        end,
        highlight = {colors.red, colors.line_bg, 'bold'}
    }
}
gls.left[3] = {
    FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon_color,
            colors.line_bg
        }
    }
}
gls.left[4] = {
    FileName = {
        provider = {'FileName', 'FileSize'},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.line_bg, 'bold'}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then return true end
    return false
end

gls.left[7] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '    ',
        highlight = {colors.green, colors.line_bg}
    }
}
gls.left[8] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '    ',
        highlight = {colors.orange, colors.line_bg}
    }
}
gls.left[9] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '    ',
        highlight = {colors.red, colors.line_bg}
    }
}
gls.left[10] = {
    TrailingWhiteSpace = {
        provider = TrailingWhiteSpace,
        icon = '    ',
        highlight = {colors.yellow, colors.bg}
    }
}

gls.mid[0] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '    ',
        highlight = {colors.red, colors.bg}
    }
}
gls.mid[1] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '    ',
        highlight = {colors.yellow, colors.bg}
    }
}
gls.mid[2] = {
    DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '    ',
        highlight = {colors.purple, colors.bg}
    }
}

gls.mid[3] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '    ',
        highlight = {colors.cyan, colors.bg}
    }
}

gls.mid[4] = {
    CocFunc = {
        provider = CocFunc,
        icon = '  λ ',
        highlight = {colors.yellow, colors.bg}
    }
}

-- VistaPlugin = extension.vista_nearest
-- gls.mid[3] = {
--   Vista = {
--     provider = VistaPlugin,
--     separator = '   ',
--     separator_highlight = {colors.bg,colors.line_bg},
--     highlight = {colors.fg,colors.line_bg,'bold'},
--   }
-- }

-- gls.left[15] = {
--     CocStatus = {
--      provider = CocStatus,
--      highlight = {colors.green,colors.bg},
--      icon = '  🗱  '
--     }
-- }

gls.right[1] = {
    GitIcon = {
        provider = function() return '    ' end,
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.orange, colors.line_bg}
    }
}
gls.right[2] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.orange, colors.line_bg, 'bold'}
    }
}

gls.right[3] = {
    FileFormat = {
        provider = 'FileFormat',
        separator = ' ',
        separator_highlight = {colors.bg, colors.line_bg},
        highlight = {colors.yellow, colors.line_bg, 'bold'}
    }
}
gls.right[4] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = ' | ',
        separator_highlight = {colors.blue, colors.line_bg},
        highlight = {colors.fg, colors.line_bg}
    }
}
-- gls.right[5] = {
--   PerCent = {
--     provider = 'LinePercent',
--     separator = ' ',
--     separator_highlight = {colors.line_bg,colors.line_bg},
--     highlight = {colors.cyan,colors.darkblue,'bold'},
--   }
-- }
gls.right[5] = {
    Separator = {
        provider = function() return ' ' end,
        highlight = {colors.red, colors.bg}
    }
}

gls.right[6] = {
    ScrollBar = {provider = 'ScrollBar', highlight = {colors.red, colors.bg}}
}
gls.right[7] = {
    FirstElement = {
        provider = function() return ' ' end,
        highlight = {colors.blue, colors.line_bg}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = {'FileName'},
        icon = '  ',
        separator = ' ',
        condition = has_file_type,
        separator_highlight = {colors.purple, colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        separator = '',
        condition = has_file_type,
        separator_highlight = {colors.purple, colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}
