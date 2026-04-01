pcall(function()
  if not vim.loader then
    return
  end

  local cache_dir = vim.fn.stdpath("cache") .. "/luac"
  local ok = pcall(vim.fn.mkdir, cache_dir, "p")
  if not ok then
    return
  end

  local test_path = cache_dir .. "/.loader_check"
  local fd = vim.loop.fs_open(test_path, "w", 420)
  if not fd then
    return
  end

  vim.loop.fs_close(fd)
  vim.loop.fs_unlink(test_path)
  vim.loader.enable()
end)

require("mxvim")
require("basic")
require("map")
require("utils").load_plugins()
