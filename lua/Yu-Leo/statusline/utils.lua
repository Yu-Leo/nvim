local M = {}

local function string_starts(String, Start)
  return string.sub(String, 1, string.len(Start)) == Start
end

M.get_type_by_state = function(state)
  if state.name == nil then
    return "EMPTY"
  end

  if string_starts(state.name, "NvimTree_") then
    return "NVIMTREE"
  end

  if state.name == "blame" then
    return "BLAME"
  end

  if string_starts(state.name, "Neotest") then
    return "NEOTEST"
  end

  if string_starts(state.path, "term:") then
    return "TERMINAL"
  end

  if string_starts(state.path, "fugitive:") then
    return "FUGITIVE"
  end

  if string_starts(state.path, state.cwd) then
    return "FILE_IN_CWD"
  end

  return "FILE_NOT_IN_CWD"
end

M.calculate_len = function(order, lens)
  local result = 0

  for _, v in ipairs(order) do
    local l = lens[v]
    result = result + l
  end

  return result
end

return M
