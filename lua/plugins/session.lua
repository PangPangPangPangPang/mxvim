return {
  {
    "Shatur/neovim-session-manager",
    cmd = { "SessionManager" },
    keys = {
      { "<leader>s", "<cmd>SessionManager load_session<cr>", mode = "n", desc = "Load sessions" },
    },
  },
}