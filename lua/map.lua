local dmap = require("utils").dmap

------------------------------
-- => Status line
------------------------------
-- Always show the status line
dmap({ "n" }, "<leader>==", "mzG=gg`z", "Format all")
-- Copy to system clipboard
dmap({ "v" }, "Y", '"+y')

-- dmap({ "v", "n" }, "<c-h>", "<c-w>h")
-- dmap({ "v", "n" }, "<c-j>", "<c-w>j")
-- dmap({ "v", "n" }, "<c-k>", "<c-w>k")
-- dmap({ "v", "n" }, "<c-l>", "<c-w>l")


dmap({ "n", "v" }, "<leader>q", ':lua require("utils").close_common()<cr>', "Close ignore buffer")