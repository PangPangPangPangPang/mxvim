local gl = require('galaxyline')
local gls = gl.section

gl.short_line_list = {
    'LuaTree', 'vista', 'dbui', 'startify', 'term', 'nerdtree', 'fugitive',
    'fugitiveblame', 'plug', 'defx','NvimTree'
}

local colors = require('theme').theme_colors()

vim.api.nvim_command('hi! StatusLine guibg=' .. colors.bg .. ' guifg=' ..
                         colors.bg)

local function has_file_type()
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
        highlight = {colors.blue, colors.bg}
    }
}
gls.left[2] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local alias = {
                n = 'NORMAL',
                i = 'INSERT',
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
                no = colors.magenta,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                cv = colors.red,
                ce = colors.red,
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
        highlight = {colors.red, colors.bg, 'bold'}
    }
}
gls.left[3] = {
    FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = {
            require('galaxyline.providers.fileinfo').get_file_icon_color,
            colors.bg
        }
    }
}
gls.left[4] = {
    FileName = {
        provider = {'FileName', 'FileSize'},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.bg, 'bold'}
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
        highlight = {colors.green, colors.bg}
    }
}
gls.left[8] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '    ',
        highlight = {colors.orange, colors.bg}
    }
}
gls.left[9] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '    ',
        highlight = {colors.red, colors.bg}
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

-- gls.mid[4] = {
--     CocFunc = {
--         provider = CocFunc,
--         icon = '  λ ',
--         separator_highlight = {colors.bg,colors.bg},
--         highlight = {colors.yellow, colors.bg}
--     }
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
        condition = require('galaxyline.providers.vcs').check_git_workspace,
        highlight = {colors.orange, colors.bg}
    }
}
gls.right[2] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = require('galaxyline.providers.vcs').check_git_workspace,
        highlight = {colors.orange, colors.bg, 'bold'}
    }
}

gls.right[3] = {
    FileFormat = {
        provider = 'FileFormat',
        separator = ' ',
        highlight = {colors.yellow, colors.bg, 'bold'}
    }
}
gls.right[4] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = ' | ',
        highlight = {colors.fg, colors.bg}
    }
}
-- gls.right[5] = {
--   PerCent = {
--     provider = 'LinePercent',
--     separator = ' ',
--     separator_highlight = {colors.bg,colors.bg},
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
        highlight = {colors.blue, colors.bg}
    }
}

local function file_name()
    local fileinfo = require('galaxyline.providers.fileinfo')
    local name = fileinfo.get_current_file_name()
    if string.find(name, 'NvimTree', 1) ~= nil then
        return 'FileTree';
    end
    return fileinfo.get_current_file_name()
end

local shade_bg = require('theme').shade(colors.fg, 0.25);

gls.short_line_left[1] = {
    BufferType = {
        provider = {file_name},
        icon = '  ',
        separator = ' ',
        condition = has_file_type,
        separator_highlight = {colors.purple, shade_bg},
        highlight = {colors.fg, shade_bg}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        separator = '',
        condition = has_file_type,
        separator_highlight = {colors.purple, shade_bg},
        highlight = {colors.fg, shade_bg}
    }
}
