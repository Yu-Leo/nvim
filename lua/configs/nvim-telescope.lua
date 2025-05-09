local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    default_mappings = { -- Override default mappings
      i = {
        ["<LeftMouse>"] = {
          actions.mouse_click,
          type = "action",
          opts = { expr = true },
        },
        ["<2-LeftMouse>"] = {
          actions.double_mouse_click,
          type = "action",
          opts = { expr = true },
        },

        ["<C-j>"] = actions.move_selection_next,
        ["<Down>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Up>"] = actions.move_selection_previous,

        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,

        ["<C-q>"] = actions.close,

        ["<CR>"] = actions.select_default,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<M-k>"] = actions.preview_scrolling_up,
        ["<M-j>"] = actions.preview_scrolling_down,
        ["<M-h>"] = actions.preview_scrolling_left,
        ["<M-l>"] = actions.preview_scrolling_right,

        ["<C-c>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-c>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      n = {
        ["<LeftMouse>"] = {
          actions.mouse_click,
          type = "action",
          opts = { expr = true },
        },
        ["<2-LeftMouse>"] = {
          actions.double_mouse_click,
          type = "action",
          opts = { expr = true },
        },

        ["<esc>"] = actions.close,
        ["q"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-c>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-c>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,

        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<M-k>"] = actions.preview_scrolling_up,
        ["<M-j>"] = actions.preview_scrolling_down,
        ["<M-h>"] = actions.preview_scrolling_left,
        ["<M-l>"] = actions.preview_scrolling_right,

        ["?"] = actions.which_key,
      },
    },
    file_ignore_patterns = {
      "%.git/",
      "%.idea/",
      "node_modules/",
      "pkg/",
      "vendor/",
    },
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
      width = 0.87,
      height = 0.80,
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true,
    },
    buffers = {
      prompt_title = "Find Buffers",
    },
  },
  extensions = {
    ["recent-files"] = {
      prompt_title = "Find Files",
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true,
    },
  },
}

telescope.load_extension "recent-files"
telescope.load_extension "git_file_history"
