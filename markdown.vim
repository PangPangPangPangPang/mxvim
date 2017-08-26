nmap <leader>m1 mpI#<space><esc>`p
nmap <leader>m2 mpI##<space><esc>`p
nmap <leader>m3 mpI###<space><esc>`p
nmap <leader>m4 mpI####<space><esc>`p
nmap <leader>m5 mpI#####<space><esc>`p

vnoremap <leader>md mp:<C-u>call visual#action('s/foo/**foo**/g')<CR>`p
vnoremap <leader>mi mp:<C-u>call visual#action('s/foo/*foo*/g')<CR>`p
