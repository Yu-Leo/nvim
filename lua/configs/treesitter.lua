local brief_exists, brief = pcall(require, "private.brief")

local ensure_installed = {
  "lua",
  "luadoc",
  "printf",
  "vim",
  "vimdoc",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "gowork",
  "toml",
  "yaml",
  "hjson",
  "markdown",
  "gitignore",
  "python",
  "javascript",
  "html",
  "css",
  "typescript",
  "tsx",
  "dockerfile",
  "make",
  "cmake",
  "cpp",
  "sql",
  "json",
}

if brief_exists then
  table.insert(ensure_installed, "brief")
end

require("nvim-treesitter.configs").setup {
  ensure_installed = ensure_installed,
  highlight = {
    enable = true,
    use_languagetree = true,
  },

  sync_install = false,
  auto_install = true,

  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["at"] = "@comment.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        [">a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<a"] = "@parameter.inner",
      },
    },
  },
}

if brief_exists then
  brief.setup_nvim_treesitter()
end
