local M = {}

local function go_to_go_test_file()
  local cwf = vim.fn.expand "%:."
  if string.find(cwf, "_test%.go$") then
    vim.fn.execute("edit " .. string.gsub(cwf, "(%w+)_test%.go$", "%1.go"))
    return true
  elseif string.find(cwf, "%.go$") then
    vim.fn.execute("edit " .. string.gsub(cwf, "(%w+)%.go$", "%1_test.go"))
    return true
  end
  return false
end

M.go_to_test_file = function()
  local filetype = vim.bo.filetype

  if filetype == "go" then
    if go_to_go_test_file() then
      return
    end
  end

  vim.notify "No test file was found to switch to"
end

local check_go_custom_linter = function()
  local lint = require "lint"
  local cfg_names = { ".golangci-lint.yaml", ".golangci.yml" }

  for _, cfg in ipairs(cfg_names) do
    local config = vim.fn.getcwd() .. "/" .. cfg
    if vim.fn.filereadable(config) == 1 then
      vim.b.custom_lint_config = true
      lint.linters.golangcilint.args = {
        "run",
        "--out-format",
        "json",
        "--show-stats=false",
        "--print-issued-lines=false",
        "--print-linter-name=false",
        "-c",
        config,
      }
      break
    end
  end
end

M.check_custom_linters = function()
  local lint = require "lint"
  vim.b.custom_lint_config = false
  vim.b.lint_running = false

  if vim.bo.filetype == "go" then
    check_go_custom_linter()
  end

  lint.try_lint()
  vim.b.lint_running = false
  if #lint.get_running(require("nvchad.stl.utils").stbufnr()) >= 1 then
    vim.b.lint_running = true
  end
end

return M
