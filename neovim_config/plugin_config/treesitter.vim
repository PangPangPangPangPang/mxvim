if !Installed("nvim-treesitter")
    finish
endif
if has('nvim-0.5')
    highlight link TSError Normal
    highlight link TSPunctBracket Normal 
lua <<EOF
require "nvim-treesitter.highlight"
local hlmap = vim.treesitter.TSHighlighter.hl_map

--Misc
hlmap.error = nil
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,                    -- false will disable the whole extension
        disable = { 'c', 'rust' },        -- list of language that will be disabled
        custom_captures = {               -- mapping of user defined captures to highlight groups
          -- ["foo.bar"] = "Identifier"   -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
        },            
    },
    incremental_selection = {
        enable = true,
        disable = { 'cpp', 'lua' },
        keymaps = {                       -- mappings for incremental selection (visual mappings)
          init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
          node_incremental = "grn",       -- increment to the upper named parent
          scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "grm",       -- decrement to the previous node
        }
    },
    refactor = {
      highlight_definitions = {
        enable = false
      },
      highlight_current_scope = {
        enable = false
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr"            -- mapping to rename reference under cursor
        }
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",        -- mapping to go to definition of symbol under cursor
          list_definitions = "gnD"        -- mapping to list all definitions in current file
        }
      }
    },
    ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
}
EOF
endif
