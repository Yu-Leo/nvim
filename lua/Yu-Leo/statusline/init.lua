local nv_utils = require "nvchad.stl.utils"
local utils = require "Yu-Leo.statusline.utils"

local M = {}

-- <! Render blocks
local render_block_mode = function(_)
  if not nv_utils.is_activewin() then
    return "", 0
  end

  local modes = nv_utils.modes
  local m = vim.api.nvim_get_mode().mode
  local mode = "%#StMode" .. modes[m][2] .. "#" .. "█" .. "%#StBase#"

  return mode, 1
end

local get_lsp_icon = function(state)
  if rawget(vim, "lsp") then
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[state.bufnr] then
        return " ⚙"
      end
    end
  end

  return ""
end

local get_lint_icon = function(_)
  if vim.b.lint_running then
    if vim.b.custom_lint_config then
      return " ⛊"
    end
    return " ⛉"
  end
  return ""
end

local get_autoformat_icon = function(_)
  if not vim.g.disable_autoformat then
    return " ⊜"
  end
  return ""
end

local get_ts_icon = function(state)
  if vim.treesitter.highlighter.active[state.bufnr] ~= nil then
    return " ⦾"
  end
  return ""
end

local get_content_block_name = function(state)
  local type = state.type

  local icon = "󰈚"
  if type == "EMPTY" then
    return " " .. icon .. " " .. "Empty" .. " "
  end

  if type == "NVIMTREE" then
    return " " .. "" .. " " .. "NvimTree" .. " "
  end

  if type == "NEOTEST" then
    return " " .. "☯" .. " " .. "NeoTest" .. " "
  end

  if type == "TERMINAL" then
    return " " .. "" .. " " .. state.name .. " "
  end

  if type == "BLAME" then
    return " " .. "♜" .. " " .. "GitBlame" .. " "
  end

  if type == "FILE_IN_CWD" or type == "FILE_NOT_IN_CWD" or type == "FUGITIVE" then
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")
    if devicons_present then
      local ft_icon = devicons.get_icon(state.name)
      icon = (ft_icon ~= nil and ft_icon) or icon
    end
    return " "
      .. icon
      .. " "
      .. state.name
      .. get_lsp_icon(state)
      .. get_lint_icon(state)
      .. get_autoformat_icon(state)
      .. get_ts_icon(state)
      .. " "
  end

  return ""
end

local render_block_name = function(state)
  local content = get_content_block_name(state)
  return "%#StName#" .. content .. "%#StBase#", vim.fn.strdisplaywidth(content)
end

local render_block_git_head = function(state)
  local type = state.type
  if type == "FILE_IN_CWD" or type == "FILE_NOT_IN_CWD" then
    if not vim.b[state.bufnr].gitsigns_head or vim.b[state.bufnr].gitsigns_git_status then
      return "", 0
    end
    local head = vim.b[state.bufnr].gitsigns_status_dict.head
    local content = "  " .. head .. " "
    return "%#StGitHead#" .. content .. "%#StBase#", vim.fn.strdisplaywidth(content)
  end

  if type == "NEOTEST" or type == "NVIMTREE" or type == "EMPTY" or type == "BLAME" then
    local head = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
    if head:match "fatal" then
      return "", 0
    end
    local content = "  " .. head .. " "
    return "%#StGitHead#" .. content .. "%#StBase#", vim.fn.strdisplaywidth(content)
  end

  if type == "FUGITIVE" then
    local hash, _ = string.match(state.path, ".git//([0-9a-f]+)(/.*)")
    if hash then
      local head = hash:sub(1, 7)
      local content = "  " .. head .. " "
      return "%#StGitHead#" .. content .. "%#StBase#", vim.fn.strdisplaywidth(content)
    end
    return "", 0
  end

  return "", 0
end

local render_block_path_full = function(state)
  local type = state.type
  if type == "EMPTY" or type == "NVIMTREE" or type == "NEOTEST" or type == "TERMINAL" or type == "BLAME" then
    local content = "  " .. state.cwd:match "([^/\\]+)[/\\]*$" .. "/ "
    return "%#StPath#" .. content, vim.fn.strdisplaywidth(content)
  end

  if type == "FILE_IN_CWD" then
    local content = "  " .. state.cwd:match "([^/\\]+)[/\\]*$" .. "/" .. vim.fn.expand "%:~:." .. " "
    return "%#StPath#" .. content, vim.fn.strdisplaywidth(content)
  end

  if type == "FILE_NOT_IN_CWD" then
    local content = " " .. vim.fn.expand "%:~" .. " "
    return "%#StPath#" .. content, vim.fn.strdisplaywidth(content)
  end

  if type == "FUGITIVE" then
    local _, path = string.match(state.path, ".git//([0-9a-f]+)(/.*)")
    if path then
      local content = "  " .. state.cwd:match "([^/\\]+)[/\\]*$" .. path .. " "
      return "%#StPath#" .. content, vim.fn.strdisplaywidth(content)
    end
    return "", 0
  end

  return "", 0
end

local render_block_path_middle = function(state)
  local type = state.type
  if type == "EMPTY" or type == "NVIMTREE" or type == "NEOTEST" or type == "TERMINAL" or type == "BLAME" then
    return "", 0
  end

  if type == "FILE_IN_CWD" then
    local content = "  " .. "/" .. vim.fn.expand "%:~:." .. " "
    return "%#StPath#" .. content, vim.fn.strdisplaywidth(content)
  end

  if type == "FUGITIVE" then
    local _, path = string.match(state.path, ".git//([0-9a-f]+)(/.*)")
    if path then
      local content = "  " .. path .. " "
      return "%#StPath#" .. content, vim.fn.strdisplaywidth(content)
    end
    return "", 0
  end

  if type == "FILE_NOT_IN_CWD" then
    local content = " " .. vim.fn.expand "%:~" .. " "
    return "%#StPath#" .. content, vim.fn.strdisplaywidth(content)
  end

  return "", 0
end

local render_block_lsp_message_full = function(state)
  if state.lsp.progress == "" and state.lsp.message == "" then
    return "", 0
  end

  local content = " " .. state.lsp.progress .. " " .. state.lsp.message .. " "
  return "%#StLspMsg#" .. content .. "%#StBase#", vim.fn.strdisplaywidth(content)
end

local render_block_lsp_message_short = function(state)
  if state.lsp.progress == "" then
    return "", 0
  end

  local content = " " .. state.lsp.progress .. " "

  return "%#StLspMsg#" .. content .. "%#StBase#", vim.fn.strdisplaywidth(content)
end

local render_block_lsp_diagnostics = function(state)
  if not rawget(vim, "lsp") then
    return ""
  end

  local err = tostring(#vim.diagnostic.get(state.bufnr, { severity = vim.diagnostic.severity.ERROR }))
  local warn = tostring(#vim.diagnostic.get(state.bufnr, { severity = vim.diagnostic.severity.WARN }))
  local hints = tostring(#vim.diagnostic.get(state.bufnr, { severity = vim.diagnostic.severity.HINT }))
  local info = tostring(#vim.diagnostic.get(state.bufnr, { severity = vim.diagnostic.severity.INFO }))

  local result_block = ""
  local result_len = 0

  if err ~= "nil" and err ~= "0" then
    local content = " " .. err .. " "
    result_block = result_block .. "%#StLspError#" .. content .. "%#StBase#"
    result_len = result_len + vim.fn.strdisplaywidth(content)
  end

  if warn ~= "nil" and warn ~= "0" then
    local content = " " .. warn .. " "
    result_block = result_block .. "%#StLspWarning#" .. content .. "%#StBase#"
    result_len = result_len + vim.fn.strdisplaywidth(content)
  end

  if hints ~= "nil" and hints ~= "0" then
    local content = "󰛩 " .. hints .. " "
    result_block = result_block .. "%#StLspHints#" .. content .. "%#StBase#"
    result_len = result_len + vim.fn.strdisplaywidth(content)
  end

  if info ~= "nil" and info ~= "0" then
    local content = "󰋼 " .. info
    result_block = result_block .. "%#StLspInfo#" .. content .. "%#StBase#"
    result_len = result_len + vim.fn.strdisplaywidth(content)
  end
  return result_block, result_len
end

local render_block_cursor = function(_)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local content = " " .. row .. ":" .. col .. " "

  return "%#StCursor#" .. content .. "%#StBase#", vim.fn.strdisplaywidth(content)
end

local render_blocks = function(order, blocks)
  local result = {}

  for _, v in ipairs(order) do
    local module = blocks[v]
    module = type(module) == "string" and module or module()
    table.insert(result, module)
  end

  return table.concat(result)
end
-- Render blocks !>

-- <! Render types
local render_type_file = function(state)
  local order = { "mode", "name", "git_head", "path", "%=", "lsp_message", "%=", "lsp_diagnostics", "cursor" }

  if utils.calculate_len(order, state.lens) > state.workspace_width then
    state.blocks.lsp_message, state.lens.lsp_message = render_block_lsp_message_short(state)
  end

  if utils.calculate_len(order, state.lens) > state.workspace_width then
    state.blocks.lsp_message, state.lens.lsp_message = "", 0
  end

  if utils.calculate_len(order, state.lens) > M.state.workspace_width then
    state.blocks.path, state.lens.path = render_block_path_middle(state)
  end

  if utils.calculate_len(order, state.lens) > M.state.workspace_width then
    state.blocks.path, state.lens.path = "", 0
  end

  if utils.calculate_len(order, state.lens) > M.state.workspace_width then
    state.blocks.git_head, state.lens.git_head = "", 0
  end

  return render_blocks(order, state.blocks)
end

local render_type_empty = function(state)
  local order = { "mode", "name", "git_head", "path", "%=", "cursor" }

  return render_blocks(order, state.blocks)
end

local render_type_nvim_tree = function(state)
  local order = { "mode", "name", "git_head", "path", "%=", "cursor" }

  return render_blocks(order, state.blocks)
end

local render_type_blame = function(state)
  local order = { "mode", "name", "git_head", "path", "%=", "cursor" }

  return render_blocks(order, state.blocks)
end

local render_type_neotest = function(state)
  local order = { "mode", "name", "git_head", "path", "%=", "cursor" }

  return render_blocks(order, state.blocks)
end

local render_type_terminal = function(state)
  local order = { "mode", "name", "git_head", "path", "%=", "cursor" }

  return render_blocks(order, state.blocks)
end

local render_type_fugitive = function(state)
  local order = { "mode", "name", "git_head", "path", "%=", "cursor" }

  if utils.calculate_len(order, state.lens) > M.state.workspace_width then
    state.blocks.path, state.lens.path = render_block_path_middle(state)
  end

  if utils.calculate_len(order, state.lens) > M.state.workspace_width then
    state.blocks.path, state.lens.path = "", 0
  end

  if utils.calculate_len(order, state.lens) > M.state.workspace_width then
    state.blocks.git_head, state.lens.git_head = "", 0
  end

  return render_blocks(order, state.blocks)
end

local render = function(state)
  local type = state.type
  if type == "FILE_IN_CWD" then
    return render_type_file(state)
  elseif type == "FILE_NOT_IN_CWD" then
    return render_type_file(state)
  elseif type == "EMPTY" then
    return render_type_empty(state)
  elseif type == "NVIMTREE" then
    return render_type_nvim_tree(state)
  elseif type == "BLAME" then
    return render_type_blame(state)
  elseif type == "NEOTEST" then
    return render_type_neotest(state)
  elseif type == "TERMINAL" then
    return render_type_terminal(state)
  elseif type == "FUGITIVE" then
    return render_type_fugitive(state)
  else
    return ""
  end
end
--  Render types !>

-- <! Main
M.state = {
  bufnr = 0,
  path = "",
  name = "",
  cwd = "",
  workspace_width = 0,
  type = "",
  blocks = {},
  lens = {},
  lsp = {
    progress = "",
    message = "",
  },
}

M.generate = function()
  M.state.bufnr = nv_utils.stbufnr()
  M.state.path = vim.api.nvim_buf_get_name(M.state.bufnr)
  M.state.name = M.state.path:match "([^/\\]+)[/\\]*$"
  M.state.cwd = vim.fn.getcwd()
  M.state.workspace_width = vim.o.columns

  M.state.type = utils.get_type_by_state(M.state)

  M.state.blocks.mode, M.state.lens.mode = render_block_mode(M.state)
  M.state.blocks.name, M.state.lens.name = render_block_name(M.state)
  M.state.blocks.git_head, M.state.lens.git_head = render_block_git_head(M.state)
  M.state.blocks.path, M.state.lens.path = render_block_path_full(M.state)
  M.state.blocks.lsp_message, M.state.lens.lsp_message = render_block_lsp_message_full(M.state)
  M.state.blocks.lsp_diagnostics, M.state.lens.lsp_diagnostics = render_block_lsp_diagnostics(M.state)
  M.state.blocks.cursor, M.state.lens.cursor = render_block_cursor(M.state)

  M.state.blocks["%="] = "%="
  M.state.lens["%="] = 0
  return render(M.state)
end

M.autocmds = function()
  vim.api.nvim_create_autocmd("LspProgress", {
    pattern = { "*" },
    callback = function(args)
      local data = args.data.params.value

      if data.kind == "end" then
        M.state.lsp.progress = ""
        M.state.lsp.message = ""
        vim.cmd.redrawstatus()
        return
      end

      if data.percentage then
        local idx = math.max(1, math.floor(data.percentage / 10))
        local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥", "" }
        local icon = spinners[idx]
        M.state.lsp.progress = icon .. " " .. data.percentage .. "%%"
      end

      if data.title and data.message then
        M.state.lsp.message = data.title .. ": " .. data.message
      elseif data.message then
        M.state.lsp.message = data.message
      elseif data.title then
        M.state.lsp.message = data.title
      else
        M.state.lsp.message = ""
      end
      vim.cmd.redrawstatus()
    end,
  })
end
-- Main !>

return M
