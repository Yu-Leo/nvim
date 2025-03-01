local lspconfig = require "lspconfig"
local map = vim.keymap.set
local util = require "lspconfig/util"

local brief_exists, brief = pcall(require, "private.brief")

vim.diagnostic.config {
  virtual_text = { prefix = "" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅙",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰋼",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
  underline = true,
  float = {
    border = "single",
  },
  severity_sort = true,
}

-- Hack to override options for hover & signature_help float windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "single"
  opts.max_width = 80
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local servers = {
  "gopls",
  "lua_ls",
  "html",
}

if brief_exists then
  brief.inject_brief_lsp()
end

local filter_references = function(result)
  if result == nil then
    return nil
  end

  if #result == 0 then
    return result
  end

  local current_position = vim.api.nvim_win_get_cursor(0)
  local current_uri = vim.uri_from_bufnr(0)

  local filtered_result = {}

  for _, ref in ipairs(result) do
    if
      ref.uri ~= current_uri
      or ref.range.start.line ~= current_position[1] - 1
      or ref.range.start.character > current_position[2]
    then
      table.insert(filtered_result, ref)
    end
  end

  return filtered_result
end

local textDocument_references_handler = function(_, result, ctx, config)
  result = filter_references(result)

  if not result or vim.tbl_isempty(result) then
    vim.notify "No references found"
    return
  end

  local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
  config = config or {}

  if #result == 1 then
    vim.lsp.util.jump_to_location(result[1], client.offset_encoding, config.reuse_win)
    return
  end

  local title = "References"
  local items = vim.lsp.util.locations_to_items(result, client.offset_encoding)

  local list = { title = title, items = items, context = ctx }
  if config.loclist then
    vim.fn.setloclist(0, {}, " ", list)
    vim.cmd.lopen()
  elseif config.on_list then
    assert(vim.is_callable(config.on_list), "on_list is not a function")
    config.on_list(list)
  else
    vim.fn.setqflist({}, " ", list)
    vim.cmd "botright copen"
  end
end

vim.lsp.handlers["textDocument/references"] = textDocument_references_handler

-- ----------------------------------DEFAULT FUNCTIONS -----------------------------------
local on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP: " .. desc }
  end

  if client.server_capabilities.signatureHelpProvider then
    client.server_capabilities.signatureHelpProvider.triggerCharacters = nil
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "go to implementation")
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "go to type definition")
  map("n", "gk", function()
    local context = { includeDeclaration = false }
    vim.lsp.buf.references(context)
  end, opts "show references")
  map("n", "K", function()
    return vim.lsp.buf.hover()
  end, opts "hover")
  map("n", "<leader>ld", function()
    return vim.diagnostic.open_float()
  end, opts "diagnostic open float")
  map("n", "<leader>ls", function()
    return vim.lsp.buf.signature_help()
  end, opts "show signature help")
  map("i", "<c-s>", function()
    return vim.lsp.buf.signature_help()
  end, opts "show signature help")
  map("n", "<leader>lr", vim.lsp.buf.rename, opts "rename")

  map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts "code action")
  map({ "n", "v" }, "<leader>ll", vim.lsp.codelens.run, opts "code lens")
end

-- disable semanticTokens
local on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
-- ----------------------------------DEFAULT FUNCTIONS -----------------------------------

-- Apply defautl settings
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

if brief_exists then
  brief.setup_brief_lsp(on_attach, on_init, capabilities)
end

-- Lua language server
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,

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
}

-- Gopls
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,

  cmd = { "gopls", "serve" },
  filetypes = { "go", "go.mod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
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
      codelenses = {
        generate = false,
        gc_details = false,
        test = false,
        tidy = false,
        regenerate_cgo = false,
        vendor = false,
      },
    },
  },
}
