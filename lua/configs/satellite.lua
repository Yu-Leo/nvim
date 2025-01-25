return {
  current_only = false,
  winblend = 50,
  zindex = 40,
  excluded_filetypes = { "blame", "NvimTree" },
  width = 2,
  handlers = {
    cursor = {
      enable = false,
    },
    search = {
      enable = false,
    },
    diagnostic = {
      enable = true,
      signs = { "━" },
      min_severity = vim.diagnostic.severity.HINT,
    },
    gitsigns = {
      enable = false,
    },
    marks = {
      enable = false,
    },
    quickfix = {
      enabled = false,
      signs = nil,
    },
  },
}
