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
  summary = {
    animated = true,
    count = true,
    enabled = true,
    expand_errors = true,
    follow = true,
    mappings = {
      help = "g?",
      run = "r",
      stop = "u",
      output = "o",
      jumpto = "i",
      target = "t",
      clear_target = "T",
      expand = { "<CR>", "<2-LeftMouse>" },
      attach = "a",
      next_failed = "J",
      prev_failed = "K",
    },
    open = "botright vsplit | vertical resize 50",
  },
}
