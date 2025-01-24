local M = {}

local Input = require "nui.input"
local event = require("nui.utils.autocmd").event

local function get_git_branch()
  local branch = vim.fn.system "git rev-parse --abbrev-ref HEAD"
  return branch:gsub("\n", "")
end

local function git_commit(mode)
  local default_value = ""

  if mode == "brname" then
    local branch_name = get_git_branch()
    if branch_name:match "fatal" then
      default_value = ""
    else
      default_value = branch_name .. ": "
    end
  end

  local input = Input({
    relative = "editor",
    position = "50%",
    size = {
      width = 50,
    },
    border = {
      style = "single",
      text = {
        top = " Commit message ",
        top_align = "center",
      },
    },
  }, {
    prompt = "> ",
    default_value = default_value,
    on_close = function() end,
    on_submit = function(value)
      vim.cmd('G commit -m "' .. value .. '"')
    end,
  })

  input:map("n", "<esc>", function()
    input:unmount()
  end)

  input:mount()

  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

M.git_stage_and_commit = function()
  vim.cmd "G add -A"
  git_commit(nil)
end

M.git_commit = function()
  git_commit(nil)
end

M.git_stage_and_commit_brname = function()
  vim.cmd "G add -A"
  git_commit "brname"
end

M.git_commit_brname = function()
  git_commit "brname"
end

M.git_checkout_branch = function()
  local input = Input({
    relative = "editor",
    position = "50%",
    size = {
      width = 50,
    },
    border = {
      style = "single",
      text = {
        top = " Branch name ",
        top_align = "center",
      },
    },
  }, {
    prompt = "> ",
    default_value = "",
    on_close = function() end,
    on_submit = function(value)
      vim.cmd("G checkout -b " .. value)
    end,
  })

  input:map("n", "<esc>", function()
    input:unmount()
  end)

  input:mount()

  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

M.git_switch_branch = function()
  local input = Input({
    relative = "editor",
    position = "50%",
    size = {
      width = 50,
    },
    border = {
      style = "single",
      text = {
        top = " Branch name ",
        top_align = "center",
      },
    },
  }, {
    prompt = "> ",
    default_value = "",
    on_close = function() end,
    on_submit = function(value)
      vim.cmd "G fetch"
      vim.cmd("G switch " .. value)
    end,
  })

  input:map("n", "<esc>", function()
    input:unmount()
  end)

  input:mount()

  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

M.git_push_set_upstream = function()
  local branch_name = get_git_branch()
  if branch_name:match "fatal" then
    branch_name = ""
  end
  vim.cmd("G push --set-upstream origin " .. branch_name)
end

return M
