vim.g.grepper = {
    simple_propt = 0,
    tools = {'rg', 'ag', 'ack', 'grep', 'findstr', 'pt', 'git'},
    rg = {
        grepprg = "rg -H --no-heading --ignore-case -g '!{*build*,*release*,*gecko*}' --vimgrep",
        grepformat = '%f:%l:%c:%m',
        escape = "^$.*+?()[]{}|"
    },
    pt = {
        grepprg = 'pt --nocolor --nogroup',
        grepformat = '%f:%l:%m',
        escape = '+*^$()[]'
    }
}
vim.api.nvim_exec([[
let g:grepper.highlight = 1
"     nnoremap <leader>f :Grepper<cr>
if executable('rg') 
    vnoremap <silent> <leader>f :call visual#action("GrepperRg 'foo'")<cr>
elseif executable('ag')
    vnoremap <silent> <leader>f :call visual#action("GrepperAg 'foo'")<cr>
    endif
    ]], false)
