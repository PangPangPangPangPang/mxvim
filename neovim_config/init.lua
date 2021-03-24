-- dofile('/home/wil/.config/nvim/lua/profiler.lua')
local g = vim.g
-- local fn = vim.fn
local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo
-- local utils = require('config.utils')
-- local opt = utils.opt
-- local autocmd = utils.autocmd
-- local map = utils.map
local api = vim.api

require('plugins')

wo.number = true


