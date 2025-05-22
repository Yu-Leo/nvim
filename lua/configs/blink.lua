return {
  keymap = {
    preset = "none",
    ["<C-i>"] = { "accept", "fallback" },
    ["<C-e>"] = { "hide" },
    ["<esc>"] = { "cancel", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },

    ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = false,
    },
  },
  sources = {
    default = {
      "lsp",
      "path",
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  cmdline = {
    keymap = {
      preset = "none",
      ["<C-i>"] = { "accept", "fallback" },
      ["<C-e>"] = { "hide" },
      ["<esc>"] = { "cancel", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },

      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },

      ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
    },
    completion = {
      menu = {
        auto_show = function(ctx)
          return vim.fn.getcmdtype() == ":"
        end,
      },
    },
  },
}
