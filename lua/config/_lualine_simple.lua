vim.o.laststatus = 3
local present, lualine = pcall(require, "lualine")
if not present then
  return
end

vim.api.nvim_create_autocmd({ "DirChanged", "TabEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd(string.format("LualineRenameTab %s", vim.fn.getcwd(0)))
  end,
})

local colors = require("theme").colors()

local fg = colors.fg
local bg = colors.line_bg or "none"

local bubbles_theme = {
  normal = { a = { fg = fg, bg = bg, gui = "bold" } },
  insert = { a = { fg = fg, bg = bg, gui = "bold" } },
  visual = { a = { fg = fg, bg = bg, gui = "bold" } },
  replace = { a = { fg = fg, bg = bg, gui = "bold" } },
  terminal = { a = { fg = fg, bg = bg, gui = "bold" } },
  command = { a = { fg = fg, bg = bg, gui = "bold" } },
}
local config = {
  options = {
    -- disabled_filetypes = { "NvimTree" },
    icons_enabled = true,

    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = bubbles_theme,
    -- section_separators = { right = " | " },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  tabline = {
    lualine_a = {
      {
        "tabs",
        max_length = vim.o.columns / 3,
        mode = 0,
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        "buffers",
      },
    },
  },
  extensions = {
    "fugitive",
    "toggleterm",
    "quickfix",
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_a, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_z, component)
end

local function ins_inactive_left(component)
  table.insert(config.inactive_sections.lualine_c, component)
end

ins_left({
  function()
    local alias = {
      n = "N",
      i = "I",
      V = "V",
      [""] = "V",
      v = "V",
      c = "C",
      ["r?"] = "C",
      rm = "R",
      R = "R",
      Rv = "V",
      s = "S",
      S = "S",
      ["r"] = "H",
      [""] = "S",
      t = "T",
      ["!"] = "S",
    }
    -- return alias[vim.fn.mode()]
    return string.format("%s", alias[vim.fn.mode()])
  end,
  padding = { left = 1 },
})

ins_left({
  "branch",
  icon = "",
  padding = { left = 2 },
})
local zf = require("config._zfvimim")
ins_right({
  -- padding = { right = 2 },
  function()
    return zf.zf_method
  end,
})

local function search_count()
  local search = vim.fn.searchcount({ maxcount = 0 }) -- maxcount = 0 makes the number not be capped at 99
  local searchCurrent = search.current
  local searchTotal = search.total
  if searchCurrent > 0 then
    return vim.fn.getreg("/") .. " [" .. searchCurrent .. "/" .. searchTotal .. "]"
  else
    return " "
  end
end

ins_left({
  search_count,
  padding = { right = 2, left = 2 },
})

local function location()
  return "Ln%2l, Col%2v"
end

ins_right({
  function()
    return " "
  end,
  color = function()
    local status = require("sidekick.status").get()
    if status then
      return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
    end
  end,
  cond = function()
    local status = require("sidekick.status")
    return status.get() ~= nil
  end,
})

ins_right({
  location,
  padding = { right = 1 },
})

-- local function encoding()
-- 	return string.upper(vim.opt.fileencoding:get())
-- end
-- ins_right({
-- 	encoding,
-- 	icons_enabled = false,
-- 	padding = { right = 2 },
-- })

ins_inactive_left({
  "filetype",
  icon_only = true,
})

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
ins_inactive_left({
  "filename",
  padding = { right = 2 },
  cond = conditions.buffer_not_empty,
})

lualine.setup(config)

vim.cmd([[
    set showtabline=1
]])
