local M = {}

local function get_func_name_pos()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local cur_node = vim.treesitter.get_node {
    bufnr = 0,
    pos = { row - 1, col },
  }

  while cur_node do
    if cur_node:type() == "function_declaration" or cur_node:type() == "method_declaration" then
      local name_nodes = cur_node:field "name"
      if #name_nodes > 0 then
        local name_node = name_nodes[1]
        local start_row, start_col, _ = name_node:start()
        return start_row, start_col
      end
    end
    cur_node = cur_node:parent()
  end

  return nil, nil
end

M.move_to_func_name = function()
  local row, col = get_func_name_pos()

  if row == nil or col == nil then
    return
  end

  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end

return M
