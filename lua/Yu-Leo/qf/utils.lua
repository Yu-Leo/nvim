local M = {}

local qf_ns = vim.api.nvim_create_namespace "Yu-Leo.quickfix.highlight"

M.get_list_info = function(info)
  local what = {
    id = info.id,
    items = 0,
    qfbufnr = 0,
  }

  if info.quickfix == 1 then
    return vim.fn.getqflist(what)
  end

  return vim.fn.getloclist(info.winid, what)
end

M.clear_hls = function(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, qf_ns, 0, -1)
end

M.apply_hls = function(bufnr, hls)
  for _, hl in ipairs(hls) do
    vim.api.nvim_buf_add_highlight(bufnr, qf_ns, hl.group, hl.line, hl.col_start, hl.col_end)
  end
end

---@param path string
---@return string
M.format_file_path = function(path)
  local cwd = vim.loop.cwd()
  local cwd_name = vim.fn.fnamemodify(cwd, ":t")
  local normalized_filepath = vim.fn.fnamemodify(path, ":p")

  if string.sub(normalized_filepath, 1, #cwd) == cwd then
    return cwd_name .. "/" .. vim.fn.fnamemodify(normalized_filepath, ":~:.")
  end

  return path
end

---Colorize some specific files
---@param path string
---@return string
M.get_hl_group_by_file_path = function(path)
  if string.find(path, "generated") then
    return "StPathYellow"
  end

  if string.find(path, "mocks/") then
    return "StPathDarkPurple"
  end

  if string.find(path, "vendor/") then
    return "StPathTeal"
  end

  if string.find(path, "_test.go") then
    return "StPathGreen"
  end

  return "Normal"
end

return M
