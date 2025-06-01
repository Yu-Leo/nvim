local M = {}

M.close_all_hidden = function()
  local open_bufs = {}

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    open_bufs[buf] = true
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
    if
      not open_bufs[buf]
      and buftype ~= "quickfix"
      and buftype ~= "nofile"
      and buftype ~= "neotest-output"
      and buftype ~= "neotest-summary"
      and buftype ~= "terminal"
    then
      pcall(vim.cmd, "confirm bdelete " .. buf)
    end
  end

  vim.cmd "redrawtabline"
end

return M
