local PathDecorator = require("nvim-tree.api").decorator.UserDecorator:extend()

function PathDecorator:new()
  self.enabled = true
  self.highlight_range = "name"
end

function PathDecorator:highlight_group(node)
  local path = node.absolute_path
  local name = node.name

  if string.find(path, "vendor/") or name == "vendor" then
    return "NvimTreePathTeal"
  end

  if string.find(path, "mocks/") or name == "mocks" then
    return "NvimTreePathDarkPurple"
  end

  if string.find(path, "generated/") or name == "generated" then
    return "NvimTreePathYellow"
  end

  if string.find(path, "_test.go") then
    return "NvimTreePathGreen"
  end

  return nil
end

return {
  PathDecorator = PathDecorator,
}
