local lint = require "lint"

lint.linters_by_ft = {
  -- lua = { "luacheck" },
  go = { "golangcilint" },
}

lint.linters.golangcilint.args = {
  "run",
  "--out-format",
  "json",
  "--show-stats=false",
  "--print-issued-lines=false",
  "--print-linter-name=false",
}
