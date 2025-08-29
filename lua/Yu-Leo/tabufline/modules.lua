local api = vim.api
local g = vim.g

local txt = require("Yu-Leo.tabufline.utils").txt
local style_buf = require("Yu-Leo.tabufline.utils").style_buf
local cur_buf = api.nvim_get_current_buf

-- TODO test 2025-08-13
local order = { "treeOffset", "buffers", "minitabs" }
-- local order = { "treeOffset", "empty", "minitabs" }
-- local order = { "treeOffset", "current_buffer", "minitabs" }
local bufwidth = 20

local M = {}

------------------------------- btn actions functions -----------------------------------

vim.cmd [[
  function! TbGoToBuf(bufnr,b,c,d)
    call luaeval('require("Yu-Leo.tabufline").goto_buf(_A)', a:bufnr)
  endfunction]]

vim.cmd [[
  function! TbKillBuf(bufnr,b,c,d) 
    call luaeval('require("Yu-Leo.tabufline").close_buffer(_A)', a:bufnr)
  endfunction]]

vim.cmd "function! TbGotoTab(tabnr,b,c,d) \n execute a:tabnr ..'tabnext' \n endfunction"

---------------------------------- functions -------------------------------------------

local function getNvimTreeWidth()
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
      return api.nvim_win_get_width(win)
    end
  end
  return 0
end

local function available_space()
  local str = ""

  for _, key in ipairs(order) do
    if key ~= "buffers" then
      str = str .. M[key]()
    end
  end

  local modules = api.nvim_eval_statusline(str, { use_tabline = true })
  return vim.o.columns - modules.width
end

------------------------------------- modules -----------------------------------------

M.treeOffset = function()
  local w = getNvimTreeWidth()
  if w == 0 then
    return ""
  end

  local cwd = "   " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t:s?$?") .. "/..."
  local pad = math.max(w - #cwd, 0)
  local padding = string.rep(" ", pad)

  return "%#NvimTreeRootFolder#" .. cwd .. padding .. "%#NvimTreeWinSeparator#" .. "│"
end

M.buffers = function()
  local buffers = {}
  local has_current = false -- have we seen current buffer yet?

  vim.t.bufs = vim.tbl_filter(vim.api.nvim_buf_is_valid, vim.t.bufs)

  for i, nr in ipairs(vim.t.bufs) do
    if ((#buffers + 1) * bufwidth) > available_space() then
      if has_current then
        break
      end

      table.remove(buffers, 1)
    end

    has_current = cur_buf() == nr or has_current
    table.insert(buffers, style_buf(nr, i, bufwidth))
  end

  return table.concat(buffers) .. txt("%=", "Fill") -- buffers + empty space
end

M.current_buffer = function()
  for i, nr in ipairs(vim.t.bufs) do
    local current = cur_buf() == nr
    if current then
      return style_buf(nr, i, bufwidth) .. txt("%=", "Fill")
    end
  end
  return txt("%=", "Fill")
end

M.empty = function()
  return txt("%=", "Fill")
end

g.TbTabsToggled = 0

M.minitabs = function()
  local fn = vim.fn
  local btn = require("Yu-Leo.tabufline.utils").btn

  local result, tabs = "", fn.tabpagenr "$"
  if tabs > 1 then
    for nr = 1, tabs, 1 do
      local tab_hl = "TabO" .. (nr == fn.tabpagenr() and "n" or "ff")
      result = result .. btn(" " .. nr .. " ", tab_hl, "GotoTab", nr)
    end
    return result
  end

  return ""
end

return function()
  local result = {}

  for _, v in ipairs(order) do
    table.insert(result, M[v]())
  end

  return table.concat(result)
end
