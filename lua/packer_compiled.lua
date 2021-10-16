-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/max/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/max/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/max/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/max/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/max/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ZFVimGitUtil = {
    load_after = {
      ZFVimIM = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/ZFVimGitUtil"
  },
  ZFVimIM = {
    after = { "ZFVimJob", "ZFVimGitUtil", "ZFVimIM_pinyin", "ZFVimIM_openapi" },
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20config._zfvimim\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/ZFVimIM"
  },
  ZFVimIM_openapi = {
    load_after = {
      ZFVimIM = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/ZFVimIM_openapi"
  },
  ZFVimIM_pinyin = {
    load_after = {
      ZFVimIM = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/ZFVimIM_pinyin"
  },
  ZFVimJob = {
    load_after = {
      ZFVimIM = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/ZFVimJob"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  bilibili_live_broadcast = {
    commands = { "BiliLive" },
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22config._bili_live\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/bilibili_live_broadcast"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua"
  },
  ["cmp-nvim-tags"] = {
    after_files = { "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-nvim-tags/after/plugin/cmp_nvim_tags.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-nvim-tags"
  },
  ["cmp-path"] = {
    after_files = { "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-path"
  },
  ["cmp-vsnip"] = {
    after = { "friendly-snippets", "vim-vsnip-integ", "vim-vsnip" },
    after_files = { "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-vsnip/after/plugin/cmp_vsnip.vim" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/cmp-vsnip",
    wants = { "friendly-snippets" }
  },
  ["coq.artifacts"] = {
    load_after = {
      coq_nvim = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/coq.artifacts"
  },
  coq_nvim = {
    after = { "coq.artifacts" },
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\16config._coq\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/coq_nvim"
  },
  ["emmet-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/emmet-vim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/filetype.nvim"
  },
  ["friendly-snippets"] = {
    load_after = {
      ["cmp-vsnip"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/friendly-snippets"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["git-messenger.vim"] = {
    commands = { "GitMessenger" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/git-messenger.vim"
  },
  ["github-nvim-theme"] = {
    config = { "\27LJ\2\nÛ\1\0\0\4\0\v\0\0216\0\0\0'\2\1\0006\3\2\0009\3\3\3&\2\3\2B\0\2\0029\0\4\0B\0\1\0016\0\0\0'\2\5\0B\0\2\0029\0\6\0B\0\1\0016\0\0\0'\2\a\0B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0>                hi! link NormalFloat cleared\n            \bcmd\bvim\23config._galaxyline\ntheme\17config._tree\vconfig\18current_theme\nmxvim\17colorscheme.\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\21config._gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23config._indentline\frequire\0" },
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lsp-trouble.nvim"] = {
    commands = { "LspTrouble", "Trouble" },
    config = { "\27LJ\2\nB\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\24config._lsp_trouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/lsp-trouble.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14signature\22config._signature\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\21config._lsp_saga\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  miramare = {
    config = { "\27LJ\2\nÛ\1\0\0\4\0\v\0\0216\0\0\0'\2\1\0006\3\2\0009\3\3\3&\2\3\2B\0\2\0029\0\4\0B\0\1\0016\0\0\0'\2\5\0B\0\2\0029\0\6\0B\0\1\0016\0\0\0'\2\a\0B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0>                hi! link NormalFloat cleared\n            \bcmd\bvim\23config._galaxyline\ntheme\17config._tree\vconfig\18current_theme\nmxvim\17colorscheme.\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/miramare"
  },
  ["nord.nvim"] = {
    config = { "\27LJ\2\nÛ\1\0\0\4\0\v\0\0216\0\0\0'\2\1\0006\3\2\0009\3\3\3&\2\3\2B\0\2\0029\0\4\0B\0\1\0016\0\0\0'\2\5\0B\0\2\0029\0\6\0B\0\1\0016\0\0\0'\2\a\0B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0>                hi! link NormalFloat cleared\n            \bcmd\bvim\23config._galaxyline\ntheme\17config._tree\vconfig\18current_theme\nmxvim\17colorscheme.\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/nord.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\19lsp.lsp_nullls\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/null-ls.nvim"
  },
  ["nvim-bqf"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/nvim-bqf"
  },
  ["nvim-cmp"] = {
    after = { "cmp-nvim-tags", "lspkind-nvim", "cmp-nvim-lua", "cmp-nvim-lsp", "cmp-path", "cmp-buffer", "cmp-vsnip" },
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\21config._nvim_cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    config = { "\27LJ\2\nD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\26config._lsp_installer\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\23config._lsp_config\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\17config._tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23config._treesitter\frequire\0" },
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    config = { "\27LJ\2\nÛ\1\0\0\4\0\v\0\0216\0\0\0'\2\1\0006\3\2\0009\3\3\3&\2\3\2B\0\2\0029\0\4\0B\0\1\0016\0\0\0'\2\5\0B\0\2\0029\0\6\0B\0\1\0016\0\0\0'\2\a\0B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0>                hi! link NormalFloat cleared\n            \bcmd\bvim\23config._galaxyline\ntheme\17config._tree\vconfig\18current_theme\nmxvim\17colorscheme.\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["prettier-number-line.nvim"] = {
    config = { "\27LJ\2\n~\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\23exclusive_filetype\1\2\0\0\rfugitive\1\0\1\tmode\fcurrent\nsetup\25prettier-number-line\frequire\0" },
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/prettier-number-line.nvim"
  },
  ["startuptime.vim"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/startuptime.vim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim"
  },
  ["tabby.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\18config._tabby\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/tabby.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22config._telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["vim-commentary"] = {
    config = { "\27LJ\2\n≠\1\0\0\6\0\n\0\0216\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\b\0'\3\6\0'\4\t\0004\5\0\0B\0\5\1K\0\1\0\agc\6v\bgcc\14<leader>/\6n\20nvim_set_keymap\bapi'kommentary_create_default_mappings\6g\bvim\0" },
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/vim-cool"
  },
  ["vim-dadbod"] = {
    commands = { "DB" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-dadbod"
  },
  ["vim-floaterm"] = {
    commands = { "FloatermToggle", "FloatermNew" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-floaterm"
  },
  ["vim-flog"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/vim-flog"
  },
  ["vim-fugitive"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-grepper"] = {
    commands = { "GrepperRg", "Grepper" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-grepper"
  },
  ["vim-maximizer"] = {
    commands = { "MaximizerToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-maximizer"
  },
  ["vim-mundo"] = {
    commands = { "MundoToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-mundo"
  },
  ["vim-nightfly-guicolors"] = {
    config = { "\27LJ\2\nÛ\1\0\0\4\0\v\0\0216\0\0\0'\2\1\0006\3\2\0009\3\3\3&\2\3\2B\0\2\0029\0\4\0B\0\1\0016\0\0\0'\2\5\0B\0\2\0029\0\6\0B\0\1\0016\0\0\0'\2\a\0B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0>                hi! link NormalFloat cleared\n            \bcmd\bvim\23config._galaxyline\ntheme\17config._tree\vconfig\18current_theme\nmxvim\17colorscheme.\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-nightfly-guicolors"
  },
  ["vim-quickui"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/vim-quickui"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/vim-rsi"
  },
  ["vim-signature"] = {
    after_files = { "/home/max/.local/share/nvim/site/pack/packer/opt/vim-signature/after/plugin/signature.vim" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-signature"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-sneak"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\18config._sneak\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-sneak"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/max/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-vsnip"] = {
    load_after = {
      ["cmp-vsnip"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    after_files = { "/home/max/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ/after/plugin/vsnip_integ.vim" },
    load_after = {
      ["cmp-vsnip"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  },
  ["vscode.nvim"] = {
    config = { "\27LJ\2\nÛ\1\0\0\4\0\v\0\0216\0\0\0'\2\1\0006\3\2\0009\3\3\3&\2\3\2B\0\2\0029\0\4\0B\0\1\0016\0\0\0'\2\5\0B\0\2\0029\0\6\0B\0\1\0016\0\0\0'\2\a\0B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0>                hi! link NormalFloat cleared\n            \bcmd\bvim\23config._galaxyline\ntheme\17config._tree\vconfig\18current_theme\nmxvim\17colorscheme.\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/max/.local/share/nvim/site/pack/packer/opt/vscode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: miramare
time([[Setup for miramare]], true)
try_loadstring("\27LJ\2\nÅ\1\0\0\4\0\6\0\0166\0\0\0009\0\1\0\v\0\1\0X\0\vÄ6\0\2\0'\2\3\0006\3\0\0009\3\4\3&\2\3\2B\0\2\0029\0\5\0B\0\1\0016\0\0\0+\1\2\0=\1\1\0K\0\1\0\nsetup\18current_theme\17colorscheme.\frequire\15init_theme\nmxvim\0", "setup", "miramare")
time([[Setup for miramare]], false)
-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21config._gitsigns\frequire\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
-- Setup for: nord.nvim
time([[Setup for nord.nvim]], true)
try_loadstring("\27LJ\2\nÅ\1\0\0\4\0\6\0\0166\0\0\0009\0\1\0\v\0\1\0X\0\vÄ6\0\2\0'\2\3\0006\3\0\0009\3\4\3&\2\3\2B\0\2\0029\0\5\0B\0\1\0016\0\0\0+\1\2\0=\1\1\0K\0\1\0\nsetup\18current_theme\17colorscheme.\frequire\15init_theme\nmxvim\0", "setup", "nord.nvim")
time([[Setup for nord.nvim]], false)
-- Setup for: ZFVimIM
time([[Setup for ZFVimIM]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20config._zfvimim\frequire\0", "setup", "ZFVimIM")
time([[Setup for ZFVimIM]], false)
-- Setup for: vim-fugitive
time([[Setup for vim-fugitive]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21config._fugitive\frequire\0", "setup", "vim-fugitive")
time([[Setup for vim-fugitive]], false)
-- Setup for: onedark.nvim
time([[Setup for onedark.nvim]], true)
try_loadstring("\27LJ\2\nÅ\1\0\0\4\0\6\0\0166\0\0\0009\0\1\0\v\0\1\0X\0\vÄ6\0\2\0'\2\3\0006\3\0\0009\3\4\3&\2\3\2B\0\2\0029\0\5\0B\0\1\0016\0\0\0+\1\2\0=\1\1\0K\0\1\0\nsetup\18current_theme\17colorscheme.\frequire\15init_theme\nmxvim\0", "setup", "onedark.nvim")
time([[Setup for onedark.nvim]], false)
-- Setup for: vim-floaterm
time([[Setup for vim-floaterm]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\bmap\25config._vim_floaterm\frequire\0", "setup", "vim-floaterm")
time([[Setup for vim-floaterm]], false)
-- Setup for: nvim-tree.lua
time([[Setup for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17config._tree\frequire\0", "setup", "nvim-tree.lua")
time([[Setup for nvim-tree.lua]], false)
-- Setup for: vscode.nvim
time([[Setup for vscode.nvim]], true)
try_loadstring("\27LJ\2\nÅ\1\0\0\4\0\6\0\0166\0\0\0009\0\1\0\v\0\1\0X\0\vÄ6\0\2\0'\2\3\0006\3\0\0009\3\4\3&\2\3\2B\0\2\0029\0\5\0B\0\1\0016\0\0\0+\1\2\0=\1\1\0K\0\1\0\nsetup\18current_theme\17colorscheme.\frequire\15init_theme\nmxvim\0", "setup", "vscode.nvim")
time([[Setup for vscode.nvim]], false)
-- Setup for: vim-maximizer
time([[Setup for vim-maximizer]], true)
try_loadstring("\27LJ\2\n™\1\0\0\a\0\n\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0'\3\3\0'\4\4\0'\5\5\0005\6\6\0B\1\5\1\18\1\0\0'\3\a\0'\4\4\0'\5\b\0005\6\t\0B\1\5\1K\0\1\0\1\0\1\vsilent\2\27:MaximizerToggle<CR>gv\6v\1\0\1\vsilent\2\25:MaximizerToggle<CR>\v<c-w>z\6n\bmap\nutils\frequire\0", "setup", "vim-maximizer")
time([[Setup for vim-maximizer]], false)
-- Setup for: nvim-colorizer.lua
time([[Setup for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nE\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20colorizer_setup\18config._other\frequire\0", "setup", "nvim-colorizer.lua")
time([[Setup for nvim-colorizer.lua]], false)
-- Setup for: symbols-outline.nvim
time([[Setup for symbols-outline.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20config._outline\frequire\0", "setup", "symbols-outline.nvim")
time([[Setup for symbols-outline.nvim]], false)
-- Setup for: vim-grepper
time([[Setup for vim-grepper]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17config._grep\frequire\0", "setup", "vim-grepper")
time([[Setup for vim-grepper]], false)
-- Setup for: vim-sneak
time([[Setup for vim-sneak]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18config._sneak\frequire\0", "setup", "vim-sneak")
time([[Setup for vim-sneak]], false)
-- Setup for: github-nvim-theme
time([[Setup for github-nvim-theme]], true)
try_loadstring("\27LJ\2\nÅ\1\0\0\4\0\6\0\0166\0\0\0009\0\1\0\v\0\1\0X\0\vÄ6\0\2\0'\2\3\0006\3\0\0009\3\4\3&\2\3\2B\0\2\0029\0\5\0B\0\1\0016\0\0\0+\1\2\0=\1\1\0K\0\1\0\nsetup\18current_theme\17colorscheme.\frequire\15init_theme\nmxvim\0", "setup", "github-nvim-theme")
time([[Setup for github-nvim-theme]], false)
-- Setup for: null-ls.nvim
time([[Setup for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19lsp.lsp_nullls\frequire\0", "setup", "null-ls.nvim")
time([[Setup for null-ls.nvim]], false)
-- Setup for: nvim-lsp-installer
time([[Setup for nvim-lsp-installer]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26config._lsp_installer\frequire\0", "setup", "nvim-lsp-installer")
time([[Setup for nvim-lsp-installer]], false)
time([[packadd for nvim-lsp-installer]], true)
vim.cmd [[packadd nvim-lsp-installer]]
time([[packadd for nvim-lsp-installer]], false)
-- Setup for: lspsaga.nvim
time([[Setup for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21config._lsp_saga\frequire\0", "setup", "lspsaga.nvim")
time([[Setup for lspsaga.nvim]], false)
-- Setup for: vim-signature
time([[Setup for vim-signature]], true)
try_loadstring("\27LJ\2\nE\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20signature_setup\18config._other\frequire\0", "setup", "vim-signature")
time([[Setup for vim-signature]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\bmap\22config._telescope\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: vim-nightfly-guicolors
time([[Setup for vim-nightfly-guicolors]], true)
try_loadstring("\27LJ\2\nÅ\1\0\0\4\0\6\0\0166\0\0\0009\0\1\0\v\0\1\0X\0\vÄ6\0\2\0'\2\3\0006\3\0\0009\3\4\3&\2\3\2B\0\2\0029\0\5\0B\0\1\0016\0\0\0+\1\2\0=\1\1\0K\0\1\0\nsetup\18current_theme\17colorscheme.\frequire\15init_theme\nmxvim\0", "setup", "vim-nightfly-guicolors")
time([[Setup for vim-nightfly-guicolors]], false)
-- Setup for: nvim-cmp
time([[Setup for nvim-cmp]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21config._nvim_cmp\frequire\0", "setup", "nvim-cmp")
time([[Setup for nvim-cmp]], false)
-- Setup for: coq_nvim
time([[Setup for coq_nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16config._coq\frequire\0", "setup", "coq_nvim")
time([[Setup for coq_nvim]], false)
-- Setup for: tabby.nvim
time([[Setup for tabby.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18config._tabby\frequire\0", "setup", "tabby.nvim")
time([[Setup for tabby.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23config._treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23config._indentline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: vim-commentary
time([[Config for vim-commentary]], true)
try_loadstring("\27LJ\2\n≠\1\0\0\6\0\n\0\0216\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0004\5\0\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\b\0'\3\6\0'\4\t\0004\5\0\0B\0\5\1K\0\1\0\agc\6v\bgcc\14<leader>/\6n\20nvim_set_keymap\bapi'kommentary_create_default_mappings\6g\bvim\0", "config", "vim-commentary")
time([[Config for vim-commentary]], false)
-- Config for: nvim-lsp-installer
time([[Config for nvim-lsp-installer]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\26config._lsp_installer\frequire\0", "config", "nvim-lsp-installer")
time([[Config for nvim-lsp-installer]], false)
-- Config for: prettier-number-line.nvim
time([[Config for prettier-number-line.nvim]], true)
try_loadstring("\27LJ\2\n~\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\23exclusive_filetype\1\2\0\0\rfugitive\1\0\1\tmode\fcurrent\nsetup\25prettier-number-line\frequire\0", "config", "prettier-number-line.nvim")
time([[Config for prettier-number-line.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file FloatermToggle lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file FloatermNew lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermNew", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'startuptime.vim'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitMessenger lua require("packer.load")({'git-messenger.vim'}, { cmd = "GitMessenger", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DB lua require("packer.load")({'vim-dadbod'}, { cmd = "DB", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GrepperRg lua require("packer.load")({'vim-grepper'}, { cmd = "GrepperRg", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspTrouble lua require("packer.load")({'lsp-trouble.nvim'}, { cmd = "LspTrouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'lsp-trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Grepper lua require("packer.load")({'vim-grepper'}, { cmd = "Grepper", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MundoToggle lua require("packer.load")({'vim-mundo'}, { cmd = "MundoToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MaximizerToggle lua require("packer.load")({'vim-maximizer'}, { cmd = "MaximizerToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file BiliLive lua require("packer.load")({'bilibili_live_broadcast'}, { cmd = "BiliLive", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'cmp-nvim-tags'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'emmet-vim'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'emmet-vim'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'cmp-nvim-tags'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'cmp-nvim-tags', 'emmet-vim'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'cmp-nvim-tags', 'emmet-vim'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'cmp-nvim-tags'}, { ft = "javascript" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Function lazy-loads
time([[Defining lazy-load function autocommands]], true)
vim.cmd[[au FuncUndefined GrepperOperator ++once lua require("packer.load")({'vim-grepper'}, {}, _G.packer_plugins)]]
time([[Defining lazy-load function autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
