local M = {}

local function string_starts(String, Start)
  return string.sub(String, 1, string.len(Start)) == Start
end

M.is_activewin = function()
  return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

M.stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.modes = {
  ["n"] = { "NORMAL", "Normal" },
  ["no"] = { "NORMAL (no)", "Normal" },
  ["nov"] = { "NORMAL (nov)", "Normal" },
  ["noV"] = { "NORMAL (noV)", "Normal" },
  ["noCTRL-V"] = { "NORMAL", "Normal" },
  ["niI"] = { "NORMAL i", "Normal" },
  ["niR"] = { "NORMAL r", "Normal" },
  ["niV"] = { "NORMAL v", "Normal" },
  ["nt"] = { "NTERMINAL", "NTerminal" },
  ["ntT"] = { "NTERMINAL (ntT)", "NTerminal" },

  ["v"] = { "VISUAL", "Visual" },
  ["vs"] = { "V-CHAR (Ctrl O)", "Visual" },
  ["V"] = { "V-LINE", "Visual" },
  ["Vs"] = { "V-LINE", "Visual" },
  [""] = { "V-BLOCK", "Visual" },

  ["i"] = { "INSERT", "Insert" },
  ["ic"] = { "INSERT", "Insert" },
  ["ix"] = { "INSERT", "Insert" },

  ["t"] = { "TERMINAL", "Terminal" },

  ["R"] = { "REPLACE", "Replace" },
  ["Rc"] = { "REPLACE (Rc)", "Replace" },
  ["Rx"] = { "REPLACEa (Rx)", "Replace" },
  ["Rv"] = { "V-REPLACE", "Replace" },
  ["Rvc"] = { "V-REPLACE (Rvc)", "Replace" },
  ["Rvx"] = { "V-REPLACE (Rvx)", "Replace" },

  ["s"] = { "SELECT", "Select" },
  ["S"] = { "S-LINE", "Select" },
  [""] = { "S-BLOCK", "Select" },
  ["c"] = { "COMMAND", "Command" },
  ["cv"] = { "COMMAND", "Command" },
  ["ce"] = { "COMMAND", "Command" },
  ["cr"] = { "COMMAND", "Command" },
  ["r"] = { "PROMPT", "Confirm" },
  ["rm"] = { "MORE", "Confirm" },
  ["r?"] = { "CONFIRM", "Confirm" },
  ["x"] = { "CONFIRM", "Confirm" },
  ["!"] = { "SHELL", "Terminal" },
}

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

  if string_starts(state.name, "Curl output_") then
    return "CURLOUTPUT"
  end

  if state.name == "DiffviewFilePanel" then
    return "DIFFVIEWFILEPANEL"
  end

  if string_starts(state.path, "term:") then
    return "TERMINAL"
  end

  if string_starts(state.path, "fugitive:") then
    return "FUGITIVE"
  end

  if string_starts(state.path, "diffview:") then
    return "DIFFVIEWFILE"
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
