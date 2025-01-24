vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

vim.g.maplocalleader = ","

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    import = "plugins",
  },
}, lazy_config)

require "options"
require "autocmds"
require "usercmds"

vim.schedule(function()
  require "mappings"
end)
