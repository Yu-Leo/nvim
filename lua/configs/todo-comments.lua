return {
  signs = false,
  highlight = {
    multiline = false,
    keyword = "fg",
    pattern = [[.*<(KEYWORDS)\s*]],
  },
  merge_keywords = false,
  keywords = {
    FIX = {
      icon = " ",
      alt = { "FIXME", "FIXIT", "ISSUE", "fixme", "FixMe" },
      color = "info",
    },
    TODO = {
      icon = " ",
      color = "info",
    },
  },
  search = {
    pattern = [[\s(KEYWORDS)]],
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--hidden",
    },
  },
}
