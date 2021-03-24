local map = require('utils').map

map('v', '<leader>r', ':call visual#replace('%s/foo//g')<CR><left><left>', silent)
