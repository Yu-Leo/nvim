local nvim_tree = require "nvim-tree"
local yu_leo_nvim_tree = require "Yu-Leo.nvim-tree"

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "Nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts "CD")
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "a", api.fs.create, opts "Create File Or Directory")
  vim.keymap.set("n", "y", api.fs.copy.node, opts "Copy")
  vim.keymap.set("n", "d", api.fs.trash, opts "Trash")
  vim.keymap.set("n", "g?", api.tree.toggle_help, opts "Help")
  vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
  vim.keymap.set("n", "q", api.tree.close, opts "Close")
  vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
  vim.keymap.set("n", "x", api.fs.cut, opts "Cut")
  vim.keymap.set("n", "c", api.fs.copy.filename, opts "Copy Name")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Parent close")
  vim.keymap.set("n", "e", api.fs.rename_basename, opts "Rename: Basename")
  vim.keymap.set("n", "gc", api.fs.copy.absolute_path, opts "Copy Absolute Path")
  vim.keymap.set("n", "C", api.fs.copy.relative_path, opts "Copy Relative Path")
  vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
end

nvim_tree.setup {
  on_attach = my_on_attach,
  filters = {
    dotfiles = false,
  },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  git = {
    enable = true,
    ignore = false,
  },
  renderer = {
    decorators = {
      yu_leo_nvim_tree.PathDecorator,
      "Git",
      "Open",
      "Hidden",
      "Modified",
      "Bookmark",
      "Diagnostics",
      "Copied",
      "Cut",
    },
    root_folder_label = false,
    highlight_git = "name",
    highlight_diagnostics = "name",
    special_files = {},
    indent_markers = { enable = true },
    icons = {
      show = {
        git = false,
        diagnostics = false,
      },
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
      },
    },
  },
  actions = {
    file_popup = {
      open_win_config = {
        border = "single",
      },
    },
    open_file = {
      resize_window = false,
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    debounce_delay = 100,
    severity = {
      min = vim.diagnostic.severity.ERROR,
      max = vim.diagnostic.severity.ERROR,
    },
  },
  log = {
    enable = false,
    types = {
      diagnostics = true,
    },
  },
}
