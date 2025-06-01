local utils = require "lsp.utils"

vim.diagnostic.config {
  virtual_lines = false,
  virtual_text = {
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  underline = true,
  float = {
    border = "single",
  },
  severity_sort = true,
}

utils.remove_default_mappings()

vim.lsp.config("gopls", {
  cmd = { "gopls", "serve" },
  filetypes = { "go", "go.mod" },
  root_markers = { "go.work", "go.mod", ".git" },
  on_init = utils.on_init,
  on_attach = utils.on_attach,
  settings = {
    gopls = {
      completeUnimported = true,
      codelenses = {
        generate = false,
        gc_details = false,
        test = false,
        tidy = false,
        regenerate_cgo = false,
        vendor = false,
      },
      analyses = {
        unusedvariable = true,
        shadow = true,

        -- duplicated by default golangci-lint config
        appends = false,
        assign = false,
        atomic = false,
        composites = false,
        defers = false,
        httpresponse = false,
        ifaceassert = false,
        lostcancel = false,
        nilness = false,
        simplifycompositelit = false,
        simplifyrange = false,
        simplifyslice = false,
        waitgroup = false,
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".git", ".luarc.json", ".luarc.jsonc" },
  on_init = utils.on_init,
  on_attach = utils.on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

local brief_exists, brief = pcall(require, "private.brief")
if brief_exists then
  brief.setup_briefls(utils.on_attach, utils.on_init)
end

vim.lsp.enable {
  "gopls",
  "lua_ls",
}
