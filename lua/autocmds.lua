local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

require("Yu-Leo.statusline").autocmds()

autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if vim.g.disable_autoformat then
      return
    end
    require("conform").format {
      bufnr = args.buf,
    }
  end,
})

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

autocmd({ "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    require("lint").try_lint()
  end,
})

autocmd({ "LspAttach", "BufWritePost" }, {
  callback = function(_)
    vim.lsp.codelens.refresh { bufnr = 0 }
  end,
})

-- Use golangci-lint config from cwd if it exists
autocmd({ "LspAttach" }, {
  callback = function(_)
    require("Yu-Leo.common").check_custom_linters()
  end,
})

-- For refresh nvim-tree after switching form the diffview tab
autocmd({ "TabEnter" }, {
  callback = function(_)
    require("nvim-tree.api").tree.reload()
  end,
})
