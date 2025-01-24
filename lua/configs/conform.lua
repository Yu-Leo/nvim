local options = {
  formatters_by_ft = {
    lua = { "stylua", lsp_format = "fallback" },
    -- go = { "goimports", "golines", "gofumpt", lsp_format = "never" },
    go = { "goimports", "gofmt", lsp_format = "never" },
  },
  default_format_opts = {
    lsp_format = "prefer", -- format using only lsp by default
  },
}

return options
