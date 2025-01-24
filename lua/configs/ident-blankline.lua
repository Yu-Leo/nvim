local ibl = require "ibl"
local hooks = require "ibl.hooks"

hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

ibl.setup {
  indent = {
    char = "│",
    highlight = "IblChar",
  },
  scope = {
    show_start = false,
    show_end = false,
    char = "│",
    highlight = "IblScopeChar",
  },
}
