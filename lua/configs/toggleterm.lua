return {
  winbar = {
    enabled = true,
    name_formatter = function(term)
      return "term#" .. tostring(term.id)
    end,
  },
  highlights = {
    Normal = {
      link = "Normal",
    },
    NormalFloat = {
      link = "Normal",
    },
    FloatBorder = {
      link = "Normal",
    },
    SignColumn = {
      link = "Normal",
    },
    EndOfBuffer = {
      link = "Normal",
    },
    WinBarActive = {
      link = "MoreMsg",
    },
    WinBarInactive = {
      link = "Normal",
    },
    WinBar = {
      link = "Normal",
    },
    WinBarNC = {
      link = "Normal",
    },
  },
}
