return {
  highlight = {
    groups = {
      match = "FlashMatch",
      current = "FlashCurrent",
      backdrop = "FlashBackdrop",
      label = "IncSearch",
    },
  },
  jump = {
    autojump = true,
  },
  modes = {
    char = {
      enabled = true,
      jump_labels = true,
      multi_line = false,
      jump = {
        autojump = true,
      },
      highlight = {
        backdrop = false,
        groups = {
          match = "",
        },
      },
    },
  },
}
