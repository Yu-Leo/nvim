local neotest = require "neotest"

neotest.setup {
  adapters = {
    require "neotest-golang",
  },
  floating = {
    border = "single",
  },
  quickfix = {
    enabled = false,
    open = false,
  },
}
