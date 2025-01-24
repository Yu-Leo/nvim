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
    "nvzone/volt",
  },
  {
    "nvzone/menu",
  },
  {
    "nvzone/minty",
    cmd = { "Huefy", "Shades" },
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
    opts = require "configs.nvim-tree",
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
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      debounce_delay = 500,
    },
  },
  {
    "LintaoAmons/cd-project.nvim",
    cmd = { "CdProject", "CdProjectTab", "CdProjectAdd", "CdProjectBack", "CdProjectManualAdd", "CdSearchAndAdd" },
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
    event = "BufReadPre",
    opts = {},
  },
  {
    "karb94/neoscroll.nvim",
    event = "BufEnter",
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "tenxsoydev/tabs-vs-spaces.nvim",
    config = true,
    event = "BufEnter",
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        config = function()
          require "configs.luasnip"
        end,
      },
      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        config = function()
          require "configs.nvim-autopairs"
        end,
      },
      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
      },
    },
    config = function()
      require "configs.cmp"
    end,
  },
  {
    "williamboman/mason.nvim",
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
      require "configs.treesitter"
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
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
      "mollerhoj/telescope-recent-files.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-hop.nvim",
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
      require "configs.telescope"
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
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    event = { "BufReadPre" },
    cmd = { "TodoTelescope" },
    opts = require "configs.todo-comments",
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufEnter" },
    opts = {
      preview = {
        border = "single",
      },
    },
  },
  {
    "folke/snacks.nvim",
    event = { "BufEnter" },
    opts = require "configs.snacks",
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
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
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require "configs.diffview"
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      tag_options = "",
      comment_placeholder = "",
      diagnostic = false,
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "danymat/neogen",
    config = true,
    cmd = "Neogen",
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
  {
    "trevorhauter/gitportal.nvim",
    cmd = "GitPortal",
    opts = {},
  },
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
    "numToStr/Comment.nvim",
    event = { "BufEnter" },
    opts = {},
  },
  {
    "lewis6991/satellite.nvim",
    event = "BufEnter",
    opts = require "configs.satellite",
  },
  {
    "Yu-Leo/blame-column.nvim",
    dir = "~/Code/neovim/blame-column.nvim/",
    opts = {},
  },
}
