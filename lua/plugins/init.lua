return {
  {
    "NvChad/NvChad",
    branch = "v2.5",
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    config = function()
      require "configs.ident-blankline"
    end,
  },
  {
    "folke/which-key.nvim",
    enable = false, -- TODO: 2025-08-09 test
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = {},
  },
  {
    "nvchad/base46",
    init = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "configs.nvim-tree"
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = require "configs.flash",
  },
  {
    "stevearc/dressing.nvim",
    event = "BufEnter",
    opts = require "configs.dressing",
  },
  { -- TODO: 2025-08-09 test
    "okuuva/auto-save.nvim",
    version = "^1.0.0",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
        -- defer_save = { "InsertLeave", "TextChanged" },
        -- cancel_deferred_save = { "InsertEnter" },
        defer_save = {},
      },
      debounce_delay = 2000,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = require "configs.gitsigns",
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
  },
  {
    "folke/persistence.nvim",
    enable = false, -- TODO: 2025-08-09 test
    event = "BufReadPre",
    opts = {},
  },
  {
    "karb94/neoscroll.nvim",
    event = "BufEnter",
  },
  {
    "tenxsoydev/tabs-vs-spaces.nvim",
    enable = false, -- TODO: 2025-08-09 test
    config = true,
    event = "BufEnter",
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "windwp/nvim-autopairs",
        opts = {},
      },
    },
    version = "1.*",
    lazy = false,
    opts = require "configs.blink",
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = require "configs.mason",
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = require "configs.mason-tool-installer",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function()
      require "configs.nvim-treesitter"
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
  },
  {
    "nvim-treesitter/playground",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "TSPlaygroundToggle" },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "mollerhoj/telescope-recent-files.nvim",
      {
        "isak102/telescope-git-file-history.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "tpope/vim-fugitive",
        },
      },
    },
    cmd = "Telescope",
    config = function()
      require "configs.nvim-telescope"
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufEnter" },
    opts = require "configs.nvim-bqf",
  },
  {
    "folke/snacks.nvim",
    event = { "BufEnter" },
    opts = require "configs.snacks",
  },
  {
    "nvim-neotest/neotest",
    cmd = "Neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "fredrikaverpil/neotest-golang",
        version = "*",
      },
    },
    config = function()
      require "configs.neotest"
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    config = function()
      require "configs.diffview"
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require "configs.go",
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require "configs.nvim-lint"
    end,
  },
  {
    "MunifTanjim/nui.nvim",
  },
  -- TODO: 2025-08-11
  -- {
  --   "trevorhauter/gitportal.nvim",
  --   cmd = "GitPortal",
  --   opts = {},
  -- },
  {
    "echasnovski/mini.move",
    version = false,
    event = "BufRead",
    opts = require "configs.move",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    opts = require "configs.toggleterm",
  },
  {
    "Yu-Leo/blame-column.nvim",
    opts = {},
  },
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      default_flags = { "-i" },
    },
    ft = { "curl" },
  },
  {
    "Yu-Leo/gosigns.nvim",
    ft = "go",
    cmd = { "GosignsEnable", "GosignsDisable", "GosignsToggle" },
    opts = require "configs.gosigns",
  },
  {
    "polirritmico/simple-boolean-toggle.nvim",
    event = "BufEnter",
    opts = {
      overwrite_builtins = false,
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufEnter" },
    opts = {},
  },
  {
    "leath-dub/snipe.nvim",
    event = "VeryLazy",
    opts = require "configs.snipe",
  },
  {
    "kana/vim-textobj-line",
    dependencies = { "kana/vim-textobj-user" },
    event = "VeryLazy",
  },
  {
    "Julian/vim-textobj-variable-segment",
    dependencies = { "kana/vim-textobj-user" },
    event = "VeryLazy",
  },
  {
    "linrongbin16/gitlinker.nvim",
    event = "VeryLazy",
    opts = require "configs.gitlinker",
  },
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = require "configs.kulala",
  },
}
