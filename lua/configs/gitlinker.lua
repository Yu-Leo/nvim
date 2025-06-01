local router = {
  block_permalink = {
    ["^github%.com"] = "https://github.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.REV}/"
      .. "{_A.FILE}"
      .. "#L{_A.LSTART}"
      .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
    ["^gitlab%.com"] = "https://gitlab.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.REV}/"
      .. "{_A.FILE}"
      .. "#L{_A.LSTART}"
      .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
    ["^bitbucket%.org"] = "https://bitbucket.org/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/src/"
      .. "{_A.REV}/"
      .. "{_A.FILE}"
      .. "#lines-{_A.LSTART}"
      .. "{(_A.LEND > _A.LSTART and (':' .. _A.LEND) or '')}",
  },
  block_default_branch = {
    ["^github%.com"] = "https://github.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.DEFAULT_BRANCH}/"
      .. "{_A.FILE}"
      .. "#L{_A.LSTART}"
      .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
    ["^gitlab%.com"] = "https://gitlab.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.DEFAULT_BRANCH}/"
      .. "{_A.FILE}"
      .. "#L{_A.LSTART}"
      .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
    ["^bitbucket%.org"] = "https://bitbucket.org/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/src/"
      .. "{_A.DEFAULT_BRANCH}/"
      .. "{_A.FILE}"
      .. "#lines-{_A.LSTART}"
      .. "{(_A.LEND > _A.LSTART and (':' .. _A.LEND) or '')}",
  },
  block_current_branch = {
    ["^github%.com"] = "https://github.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.CURRENT_BRANCH}/"
      .. "{_A.FILE}"
      .. "#L{_A.LSTART}"
      .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
    ["^gitlab%.com"] = "https://gitlab.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.CURRENT_BRANCH}/"
      .. "{_A.FILE}"
      .. "#L{_A.LSTART}"
      .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
    ["^bitbucket%.org"] = "https://bitbucket.org/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/src/"
      .. "{_A.CURRENT_BRANCH}/"
      .. "{_A.FILE}"
      .. "#lines-{_A.LSTART}"
      .. "{(_A.LEND > _A.LSTART and (':' .. _A.LEND) or '')}",
  },
  file_permalink = {
    ["^github%.com"] = "https://github.com/" .. "{_A.ORG}/" .. "{_A.REPO}/blob/" .. "{_A.REV}/" .. "{_A.FILE}",
    ["^gitlab%.com"] = "https://gitlab.com/" .. "{_A.ORG}/" .. "{_A.REPO}/blob/" .. "{_A.REV}/" .. "{_A.FILE}",
    ["^bitbucket%.org"] = "https://bitbucket.org/" .. "{_A.ORG}/" .. "{_A.REPO}/src/" .. "{_A.REV}/" .. "{_A.FILE}",
  },
  file_default_branch = {
    ["^github%.com"] = "https://github.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.DEFAULT_BRANCH}/"
      .. "{_A.FILE}",
    ["^gitlab%.com"] = "https://gitlab.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.DEFAULT_BRANCH}/"
      .. "{_A.FILE}",
    ["^bitbucket%.org"] = "https://bitbucket.org/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/src/"
      .. "{_A.DEFAULT_BRANCH}/"
      .. "{_A.FILE}",
  },
  file_current_branch = {
    ["^github%.com"] = "https://github.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.CURRENT_BRANCH}/"
      .. "{_A.FILE}",
    ["^gitlab%.com"] = "https://gitlab.com/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/blob/"
      .. "{_A.CURRENT_BRANCH}/"
      .. "{_A.FILE}",
    ["^bitbucket%.org"] = "https://bitbucket.org/"
      .. "{_A.ORG}/"
      .. "{_A.REPO}/src/"
      .. "{_A.CURRENT_BRANCH}/"
      .. "{_A.FILE}",
  },
}

local function get_private_router()
  local private_exists, private = pcall(require, "private")
  if not private_exists then
    return {}
  end

  local gitlinker_exists, gitlinker_private_router = pcall(private.gitlinker)
  if not gitlinker_exists then
    return {}
  end

  return gitlinker_private_router
end

for section, patterns in pairs(get_private_router()) do
  if router[section] then
    for pattern, url_template in pairs(patterns) do
      router[section][pattern] = url_template
    end
  else
    router[section] = patterns
  end
end

return {
  message = false,
  router = router,
  highlight_duration = 0,
}
