local g = vim.g
g.neoformat_only_msg_on_error = 1
g.neoformat_basic_format_align = 1
g.neoformat_basic_format_retab = 1
g.neoformat_basic_format_trim = 1

-- python
g.neoformat_enabled_python = {'autopep8'}
g.neoformat_python_autopep8 = {exe = 'autopep8', args = {'--max-line-length=100'}}

-- lua
g.neoformat_enabled_lua = {'luaformat'}
g.neoformat_lua_luaformat = {exe = 'lua-format'}

-- javascript
g.neoformat_enabled_javascript = {'prettier'}

-- typescript
g.neoformat_enabled_typescript = {'prettier'}

-- json
g.neoformat_enabled_json = {'prettier'}

-- yaml
g.neoformat_enabled_yaml = {'prettier'}
g.neoformat_yaml_prettier = {
    exe = 'prettier',
    args = {'--stdin-filepath', '"%:p"', '--tab-width=2'},
    stdin = 1
}

-- sql
g.neoformat_enabled_sql = {'sqlformatter'}
g.neoformat_sql_sqlformatter = {exe = 'sql-formatter', stdin = 1}
