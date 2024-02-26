return {
  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      if vim.fn.argc() == 0 then
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {
          [[   __  ___                     _  __   __     _   __ _      ]],
          [[  /  |/  /___ ___ __  _    __ (_)/ /_ / /    | | / /(_)__ _ ]],
          [[ / /|_/ // _ `/\ \ / | |/|/ // // __// _ \   | |/ // //  ' \]],
          [[/_/  /_/ \_,_//_\_\  |__,__//_/ \__//_//_/   |___//_//_/_/_/]],
        }

        dashboard.section.buttons.val = {
          dashboard.button("<leader> S", "  Open Session", "<cmd>SessionManager load_session<CR>"),
          dashboard.button("q", "󰅚  Quit NVIM", "<cmd>qa<CR>"),
        }
        local handle = io.popen("fortune")
        if handle == nil then
          return
        end
        local fortune = handle:read("*a")
        handle:close()
        dashboard.section.footer.val = fortune

        dashboard.config.opts.noautocmd = true

        vim.cmd([[autocmd User AlphaReady echo 'ready']])

        alpha.setup(dashboard.config)
      end
    end,
  },
  {
    "Shatur/neovim-session-manager",
    cmd = { "SessionManager" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>s", "<cmd>SessionManager load_session<cr>", mode = "n", desc = "Load sessions" },
    },
  },
}