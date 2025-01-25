local private_exists, private = pcall(require, "private")

local gitbrowse_remote_patterns = {
  { "^(https?://.*)%.git$", "%1" },
  { "^git@(.+):(.+)%.git$", "https://%1/%2" },
  { "^git@(.+):(.+)$", "https://%1/%2" },
  { "^git@(.+)/(.+)$", "https://%1/%2" },
  { "^ssh://git@(.*)$", "https://%1" },
  { "^ssh://([^:/]+)(:%d+)/(.*)$", "https://%1/%3" },
  { "^ssh://([^/]+)/(.*)$", "https://%1/%2" },
  { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
  { "^https://%w*@(.*)", "https://%1" },
  { "^git@(.*)", "https://%1" },
  { ":%d+", "" },
  { "%.git$", "" },
}

local gitbrowse_url_patterns = {
  ["github%.com"] = {
    branch = "/tree/{branch}",
    file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
    commit = "/commit/{commit}",
  },
  ["gitlab%.com"] = {
    branch = "/-/tree/{branch}",
    file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
    commit = "/-/commit/{commit}",
  },
  ["bitbucket%.org"] = {
    branch = "/src/{branch}",
    file = "/src/{branch}/{file}#lines-{line_start}-L{line_end}",
    commit = "/commits/{commit}",
  },
}

if private_exists then
  local private_remote_patterns = private.get_private_remote_pattern()
  if private_remote_patterns ~= nil then
    table.insert(gitbrowse_remote_patterns, 1, private_remote_patterns)
  end

  local private_url_patterns = private.get_private_url_patterns()
  if private_url_patterns ~= nil then
    gitbrowse_url_patterns = vim.tbl_deep_extend("force", gitbrowse_url_patterns, private_url_patterns)
  end
end

return {
  gitbrowse = {
    enabled = true,
    notify = false,
    remote_patterns = gitbrowse_remote_patterns,
    url_patterns = gitbrowse_url_patterns,
  },
  words = {
    enabled = true,
    debounce = 100,
    notify_jump = false,
    notify_end = true,
    foldopen = true,
    jumplist = true,
    modes = { "n", "i", "c" },
  },
}
