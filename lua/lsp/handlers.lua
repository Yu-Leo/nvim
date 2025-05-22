local M = {}

local util = require "vim.lsp.util"
local ms = require("vim.lsp.protocol").Methods

local filter_references = function(result)
  if result == nil or #result == 0 then
    return {}
  end

  local current_position = vim.api.nvim_win_get_cursor(0)
  local current_uri = vim.uri_from_bufnr(0)

  local filtered_result = {}

  for _, ref in ipairs(result) do
    if
      ref.user_data.uri ~= current_uri
      or ref.user_data.range.start.line ~= current_position[1] - 1
      or ref.user_data.range.start.character > current_position[2]
    then
      table.insert(filtered_result, ref)
    end
  end

  return filtered_result
end

local function on_done(client, items, bufnr)
  items = filter_references(items)

  if not next(items) then
    vim.notify "No references found"
    return
  end

  if #items == 1 then
    vim.lsp.util.show_document({
      uri = items[1].user_data.uri,
      range = items[1].user_data.range,
    }, client.offset_encoding, { reuse_win = true, focus = true })
    return
  end

  local list = {
    title = "References",
    items = items,
    context = {
      method = ms.textDocument_references,
      bufnr = bufnr,
    },
  }

  vim.fn.setloclist(0, {}, " ", list)
  vim.cmd.lopen()
end

M.references = function(context)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { method = ms.textDocument_references, bufnr = bufnr }
  if not next(clients) then
    return
  end

  local win = vim.api.nvim_get_current_win()

  local all_clients_items = {}

  local remaining = #clients
  for _, client in ipairs(clients) do
    local params = util.make_position_params(win, client.offset_encoding)

    ---@diagnostic disable-next-line: inject-field
    params.context = context or {
      includeDeclaration = true,
    }

    client:request(ms.textDocument_references, params, function(_, result)
      local client_items = util.locations_to_items(result or {}, client.offset_encoding)
      vim.list_extend(all_clients_items, client_items)
      remaining = remaining - 1
      if remaining == 0 then
        on_done(client, all_clients_items, bufnr)
      end
    end)
  end
end

return M
