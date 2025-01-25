local M = {
  opts = {
    close_diffview_after_commit = true,
  },
}

local Input = require "nui.input"
local event = require("nui.utils.autocmd").event

---@return string
local function get_git_branch()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
  if branch:match "fatal" then
    return ""
  end
  return branch
end

---@param branch string
---@return string
local function get_task_from_branch(branch)
  local match = branch:match "^([a-zA-Z]+%-%d+)"
  return match or ""
end

---@param mode string
---@return string
local function get_commit_default_value(mode)
  if mode == "branch" then
    local branch = get_git_branch()
    if branch ~= "" then
      return branch .. ": "
    end
  end

  if mode == "task" then
    local branch = get_git_branch()
    local task = get_task_from_branch(branch)
    if branch ~= "" and task ~= "" then
      return task .. ": "
    end
  end

  return ""
end

M.git_commit = function(mode)
  local default_value = get_commit_default_value(mode)

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
      if M.opts.close_diffview_after_commit then
        vim.cmd "DiffviewClose"
      end
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

M.git_stage_and_commit = function(mode)
  vim.cmd "G add -A"
  M.git_commit(mode)
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

-- Returns the name of the main branch: main if it exists, master otherwise.
-- https://github.com/ohmyzsh/ohmyzsh/blob/3151c9c1a330cdea66dd7d1a24810fe805298711/plugins/git/git.plugin.zsh#L34-L48
---@return string?
M.git_main_branch_name = function()
  local result = vim.fn.system "git rev-parse --git-dir 2>/dev/null"
  if result == "" then
    return
  end

  local branches = { "main", "trunk", "mainline", "default", "stable", "master" }

  for _, branch in ipairs(branches) do
    local ref = "refs/heads/" .. branch
    result = vim.fn.system("git show-ref --verify " .. ref .. " 2>/dev/null")

    if result ~= "" then
      return branch
    end
  end

  return "master"
end

M.git_checkout_main = function()
  local main_branch_name = M.git_main_branch_name()
  vim.cmd("G checkout " .. main_branch_name)
end

M.git_checkout_main_and_update = function()
  M.git_checkout_main()
  vim.cmd "G pull --rebase"
end

M.git_rebase_main = function()
  local main_branch_name = M.git_main_branch_name()
  vim.cmd("G rebase " .. main_branch_name)
end

M.git_merge_main = function()
  local main_branch_name = M.git_main_branch_name()
  vim.cmd("G merge " .. main_branch_name)
end

return M
