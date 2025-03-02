local M = {}

local utils = require "Yu-Leo.qf.utils"

function M.qftf(info)
  local list = utils.get_list_info(info)
  local qf_bufnr = list.qfbufnr
  local items = list.items

  local hls = {}
  local lines = {}

  utils.clear_hls(qf_bufnr)

  for i = info.start_idx, info.end_idx do
    local raw_item = items[i]

    if not raw_item then
      goto continue
    end

    local line, line_hls = M.format_qf_item(raw_item, i - 1)

    table.insert(lines, line)

    for _, hl in ipairs(line_hls) do
      table.insert(hls, hl)
    end

    ::continue::
  end

  vim.schedule(function()
    utils.apply_hls(qf_bufnr, hls)
  end)

  return lines
end

---Get formatted line and hl items
---@param raw_item any
---@param line_idx number
---@return string
---@return table
M.format_qf_item = function(raw_item, line_idx)
  local file_path = utils.format_file_path(vim.fn.bufname(raw_item.bufnr))
  local position = raw_item.lnum .. ":" .. raw_item.col - 1
  local text = raw_item.text:gsub("^%s*(.-)%s*$", "%1")

  local line_hls = {}

  table.insert(line_hls, {
    group = utils.get_hl_group_by_file_path(file_path),
    line = line_idx,
    col_start = 0,
    col_end = #file_path,
  })

  table.insert(line_hls, {
    group = "Comment",
    line = line_idx,
    col_start = #file_path + 2,
    col_end = #file_path + 2 + #position,
  })

  return file_path .. " |" .. position .. "| " .. text, line_hls
end

return M
