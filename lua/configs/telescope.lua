local telescope = require "telescope"
local actions = require "telescope.actions"
local lga_actions = require "telescope-live-grep-args.actions"

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
        ["<C-k>"] = actions.move_selection_previous,

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

        ["<C-h>"] = function(opts)
          require("plenary.reload").reload_module "telescope"
          telescope.extensions.hop.hop(opts)
        end,
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

        ["<C-h>"] = function(opts)
          require("plenary.reload").reload_module "telescope"
          telescope.extensions.hop.hop(opts)
        end,

        ["?"] = actions.which_key,
      },
    },
    file_ignore_patterns = {
      "%.git/",
      "%.idea/",
      "node_modules/",
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
    live_grep_args = {
      auto_quoting = true,
      prompt_title = "Find Words",
      mappings = {
        i = {
          ["<C-i>"] = lga_actions.quote_prompt(),
        },
      },
    },
    ["recent-files"] = {
      prompt_title = "Find Files",
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true,
    },
    file_browser = {
      auto_depth = true,
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true,
      prompt_path = true,
      grouped = true,
      mappings = {
        ["i"] = {
          ["<bs>"] = function(_, _) -- Override fb_actions.backspace: do not move to parent dir if prompt == ""
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<bs>", true, false, true), "tn", false)
          end,
        },
      },
    },
    hop = {
      sign_hl = "MoreMsg",
    },
  },
}

telescope.load_extension "recent-files"
telescope.load_extension "live_grep_args"
telescope.load_extension "file_browser"
telescope.load_extension "hop"
telescope.load_extension "git_file_history"
