local cmp = require "cmp"
local api = vim.api

local function next_item_with_fallback(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

local function prev_item_with_fallback(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

local function abort_with_fallback(fallback)
  if cmp.visible() then
    cmp.abort()
  else
    fallback()
  end
end

local function cmdline_mappings()
  return {
    ["<C-i>"] = { c = cmp.mapping.complete() },
    ["<C-e>"] = { c = cmp.mapping.close() },
    ["<Esc>"] = { c = abort_with_fallback },
    ["<C-y>"] = { c = cmp.mapping.confirm { select = false } },

    ["<C-j>"] = { c = next_item_with_fallback },
    ["<C-k>"] = { c = prev_item_with_fallback },
    ["<Tab>"] = { c = next_item_with_fallback },
    ["<S-Tab>"] = { c = prev_item_with_fallback },
  }
end

local function common_mappings()
  return {
    ["<C-i>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<esc>"] = cmp.mapping(abort_with_fallback, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping(next_item_with_fallback, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(prev_item_with_fallback, { "i", "s" }),

    ["<C-d>"] = cmp.mapping.open_docs(),
  }
end

local tailwind = function(entry, item)
  local entryItem = entry:get_completion_item()
  local color = entryItem.documentation

  if color and type(color) == "string" and color:match "^#%x%x%x%x%x%x$" then
    local hl = "hex-" .. color:sub(2)

    if #api.nvim_get_hl(0, { name = hl }) == 0 then
      api.nvim_set_hl(0, hl, { fg = color })
    end

    item.kind_hl_group = hl
    item.menu_hl_group = hl
  end
end

local format_func = function(entry, item)
  local icons = require "nvchad.icons.lspkind"
  local icon = icons[item.kind] or ""
  local kind = item.kind or ""

  local sources = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    go_pkgs = "[Go pkgs]",
  }

  item.menu = sources[entry.source.name]
  item.menu_hl_group = "CmpItemMenu"

  item.kind = icon

  if kind == "Color" then
    tailwind(entry, item)
  end

  return item
end

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmdline_mappings(),
  sources = cmp.config.sources {
    {
      name = "path",
    },
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  },
})

cmp.setup {
  completion = {
    completeopt = "menu,menuone",
  },
  mapping = common_mappings(),
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "go_pkgs" },
  },
  view = {
    docs = {
      auto_open = false,
    },
  },
  formatting = {
    format = format_func,
    fields = { "kind", "abbr", "menu" },
  },
  window = {
    completion = {
      scrollbar = false,
      side_padding = 1,
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
      border = "single",
    },
    documentation = {
      border = "single",
      winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
    },
  },
}
