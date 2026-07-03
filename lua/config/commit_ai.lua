-- Generate a Conventional Commit message in gitcommit buffers via the Gemini API.
-- Plain vim.system + curl, no plugin dependency. <c-c> starts a generation;
-- pressing it again while a request is running cancels it.
local M = {}

local job = nil

local prompt_template =
  [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

` ` `diff
%s
` ` `

When unsure about the module names to use in the commit message, you can refer to the last 20 commit messages in this repository:

` ` `
%s
` ` `

Output only the commit message without any explanations and follow-up suggestions.
]]

function M.generate()
  if job then
    job:kill(9)
    job = nil
    vim.notify("Commit message generation cancelled", vim.log.levels.INFO)
    return
  end

  if not vim.env.GEMINI_API_KEY then
    vim.notify("$GEMINI_API_KEY is not set", vim.log.levels.ERROR)
    return
  end

  local diff = vim.fn.system("git diff --no-ext-diff --staged")
  if vim.trim(diff) == "" then
    vim.notify("No staged changes", vim.log.levels.WARN)
    return
  end
  local logs = vim.fn.system('git log --pretty=format:"%s" -n 20')

  local bufnr = vim.api.nvim_get_current_buf()
  vim.notify("Generating commit message...", vim.log.levels.INFO)

  local this
  this = vim.system({
    "curl",
    "-s",
    "-H",
    "Content-Type: application/json",
    "-H",
    "x-goog-api-key: " .. vim.env.GEMINI_API_KEY,
    "-d",
    vim.json.encode({ contents = { { parts = { { text = string.format(prompt_template, diff, logs) } } } } }),
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent",
  }, { text = true }, function(res)
    vim.schedule(function()
      if job ~= this then
        return
      end
      job = nil
      local ok, json = pcall(vim.json.decode, res.stdout or "", { luanil = { object = true } })
      local text = ok and vim.tbl_get(json, "candidates", 1, "content", "parts", 1, "text")
      if res.code ~= 0 or not text then
        local detail = (ok and vim.tbl_get(json, "error", "message")) or res.stderr or res.stdout or ""
        vim.notify("Commit message generation failed: " .. detail, vim.log.levels.ERROR)
        return
      end
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, vim.split(vim.trim(text), "\n"))
      end
    end)
  end)
  job = this
end

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("commit_ai", { clear = true }),
    pattern = "gitcommit",
    callback = function(ev)
      vim.keymap.set("i", "<c-c>", M.generate, { buffer = ev.buf, desc = "Generate commit message" })
    end,
  })
end

return M
