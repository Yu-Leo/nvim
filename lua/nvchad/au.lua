-- Override https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/au.lua to have no "NvChad News" on first startup

local config = require "nvconfig"

if config.colorify.enabled then
  require("nvchad.colorify").run()
end
