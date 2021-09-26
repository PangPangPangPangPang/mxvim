local g = vim.g
g.Illuminate_highlightUnderCursor = 1
g.Illuminate_ftblacklist = {'defx', 'vista', 'nerdtree'}
if vim.o.background == 'dark' then
    vim.api.nvim_exec([[
        highlight IlluminatedWord gui=none term=none guibg=#444444 guifg=none ctermbg=245 ctermfg=none
        augroup illuminate_augroup
            autocmd!
            autocmd VimEnter * hi link illuminatedWord IlluminatedWord
            autocmd VimEnter * hi CocHighlightText gui=none term=none guibg=#444444 guifg=none ctermbg=245 ctermfg=none
        augroup END
    ]], false)
end
