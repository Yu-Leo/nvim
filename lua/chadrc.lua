-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

-- -@type ChadrcConfig
local M = {}

local minitabs = function()
  local fn = vim.fn
  local btn = require("nvchad.tabufline.utils").btn

  local result, tabs = "", fn.tabpagenr "$"
  if tabs > 1 then
    for nr = 1, tabs, 1 do
      local tab_hl = "TabO" .. (nr == fn.tabpagenr() and "n" or "ff")
      result = result .. btn(" " .. nr .. " ", tab_hl, "GotoTab", nr)
    end
    return result
  end

  return ""
end

M.base46 = {
  theme = "yuth0",
}

M.ui = {
  statusline = {
    enabled = false,
  },
  tabufline = {
    enabled = true,
    lazyload = false,
    order = { "treeOffset", "buffers", "minitabs" },
    modules = {
      minitabs = minitabs,
    },
  },
}

return M
