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

return M
