local M = {}

local map = vim.keymap.set

M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.on_attach = function(client, bufnr)
  -- Ignore diffview files
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname:match "diffview:///" then
    client.stop()
  end

  local function map_opts(desc)
    return { buffer = bufnr, desc = "LSP: " .. desc }
  end

  local floating_window_opts = {
    border = "single",
    max_width = 80,
  }

  map("n", "gD", vim.lsp.buf.declaration, map_opts "go to declaration")
  map("n", "gd", vim.lsp.buf.definition, map_opts "go to definition")
  map("n", "gi", vim.lsp.buf.implementation, map_opts "go to implementation")
  map("n", "gj", vim.lsp.buf.type_definition, map_opts "go to type definition")

  map("n", "gk", function()
    require("lsp.handlers").references { includeDeclaration = false }
  end, map_opts "show references")

  map("n", "K", function()
    return vim.lsp.buf.hover(floating_window_opts)
  end, map_opts "hover")

  map("n", "<leader>ld", function()
    return vim.diagnostic.open_float(floating_window_opts)
  end, map_opts "diagnostic open float")

  map("n", "<leader>ls", function()
    return vim.lsp.buf.signature_help(floating_window_opts)
  end, map_opts "show signature help")

  map("i", "<c-s>", function()
    return vim.lsp.buf.signature_help(floating_window_opts)
  end, map_opts "show signature help")

  map("n", "<leader>lr", vim.lsp.buf.rename, map_opts "rename")

  map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, map_opts "code action")
  map({ "n", "v" }, "<leader>ll", vim.lsp.codelens.run, map_opts "code lens")
end

M.remove_default_mappings = function()
  vim.keymap.del("n", "grn")
  vim.keymap.del("n", "gra")
  vim.keymap.del("n", "grr")
  vim.keymap.del("n", "gri")
  vim.keymap.del("n", "gO")
end

return M
