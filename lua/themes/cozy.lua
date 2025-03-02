local M = require "base46.themes.gruvbox" -- Base theme

local mix_col = require("base46.colors").mix

M.base_30 = {
  white = "#ebdbb2",
  darker_black = "#232323",
  black = "#282828",
  black2 = "#2e2e2e",
  one_bg = "#353535",
  one_bg2 = "#3f3f3f",
  one_bg3 = "#444444",
  grey = "#4b4b4b",
  grey_fg = "#4e4e4e",
  grey_fg2 = "#505050",
  light_grey = "#656565",
  red = "#fb4934", -- Override
  baby_pink = "#cc241d",
  pink = "#ff75a0",
  line = "#36393a",
  green = "#b8bb26",
  vibrant_green = "#a9b665",
  nord_blue = "#83a598",
  blue = "#458588",
  yellow = "#d79921",
  sun = "#fabd2f",
  purple = "#b4bbc8",
  dark_purple = "#d3869b",
  teal = "#749689",
  orange = "#e78a4e",
  cyan = "#82b3a8",
  statusline_bg = "#2c2c2c",
  lightbg = "#3d3d3d",
  pmenu_bg = "#83a598",
  folder_bg = "#749689",
}

M.base_16 = {
  base00 = "#282828",
  base01 = "#3c3836",
  base02 = "#423e3c",
  base03 = "#484442",
  base04 = "#9d8e83", -- Override
  base05 = "#d5c4a1",
  base06 = "#ebdbb2",
  base07 = "#fbf1c7",
  base08 = "#fb4934",
  base09 = "#fe8019",
  base0A = "#fabd2f",
  base0B = "#b8bb26",
  base0C = "#8ec07c",
  base0D = "#83a598",
  base0E = "#d3869b",
  base0F = "#d65d0e",
}

M.polish_hl = {
  defaults = {
    Title = { fg = M.base_16.base05 },
    Comment = { fg = M.base_16.base04 },

    -- Float
    FloatBorder = { fg = M.base_16.base0B, bg = M.base_30.darker_black },
    FloatTitle = { fg = M.base_16.base05, bg = M.base_30.darker_black },

    -- Neotest
    NeotestAdapterName = { fg = M.base_16.base0E },
    NeotestFile = { fg = M.base_16.base0D },
    NeotestDir = { fg = M.base_16.base0D },
    NeotestPassed = { fg = M.base_16.base0B },
    NeotestRunning = { fg = M.base_16.base0A },
    NeotestFailed = { fg = M.base_16.base08 },
    NeotestExpandMarker = { fg = M.base_16.base03 },
    NeotestIndent = { fg = M.base_16.base03 },
    NeotestTest = { fg = M.base_16.base05 },
    NeotestMarked = { fg = M.base_16.base09, bold = true },

    MarkSignHL = { fg = M.base_16.base0B },

    -- GitSigns
    GitSignsStagedAdd = { fg = M.base_16.base0B },
    GitSignsAdd = { fg = M.base_16.base0B },
    GitSignsAddPreview = { fg = M.base_16.base0B },

    GitSignsStagedChange = { fg = M.base_16.base0A },
    GitSignsChange = { fg = M.base_16.base0A },

    GitSignsStagedDelete = { fg = M.base_16.base08 },
    GitSignsDelete = { fg = M.base_16.base08 },

    GitSignsStagedChangedelete = { fg = M.base_16.base08 },
    GitSignsChangedelete = { fg = M.base_16.base08 },

    LspCodeLens = { fg = M.base_30.dark_purple },

    TreesitterContext = { bg = M.base_30.black },
    TreesitterContextBottom = { underline = true, sp = M.base_30.light_grey },

    DiagnosticUnderlineError = { underline = true, sp = M.base_30.red },
    DiagnosticUnderlineWarning = { underline = true, sp = M.base_30.yellow },
    DiagnosticUnderlineInfo = { underline = true, sp = M.base_30.green },
    DiagnosticUnderlineHint = { underline = true, sp = M.base_30.purple },
    DiagnosticUnderlineOk = { underline = true, sp = M.base_30.green },

    -- Spell
    SpellBad = { undercurl = true, sp = M.base_16.base08 },
    SpellCap = { undercurl = true, sp = M.base_16.base0A },
    SpellRare = { undercurl = true, sp = M.base_16.base0D },
    SpellLocal = { undercurl = true, sp = M.base_16.base0C },

    -- Diffview
    DiffviewDiffAdd = { bg = mix_col(M.base_30.green, M.base_30.black, 80) },
    DiffviewDiffText = { bg = mix_col(M.base_30.green, M.base_30.black, 60) },
    DiffviewDiffChange = { bg = mix_col(M.base_30.green, M.base_30.black, 80) },

    DiffviewDiffDelete = { bg = mix_col(M.base_30.red, M.base_30.black, 60) },
    DiffviewDiffDeleteDim = { bg = mix_col(M.base_30.red, M.base_30.black, 80) },
    DiffviewDiffAddAsDelete = { bg = mix_col(M.base_30.red, M.base_30.black, 80) },

    DiffviewFilePanelFileName = { fg = M.base_16.base05 },

    DiffviewStatusAdded = { fg = M.base_16.base0B },
    DiffviewStatusUntracked = { fg = M.base_16.base0B },
    DiffviewStatusModified = { fg = M.base_30.yellow },
    DiffviewStatusRenamed = { fg = M.base_30.yellow },
    DiffviewStatusDeleted = { fg = M.base_16.base08 },
    DiffviewStatusUnmerged = { fg = M.base_16.base08 },

    DiffviewFilePanelInsertions = { fg = M.base_16.base0B },
    DiffviewFilePanelDeletions = { fg = M.base_16.base08 },
    DiffviewFilePanelConflicts = { fg = M.base_16.base08 },

    QuickFixLine = { bg = "NONE" },
    FoldColumn = { fg = M.base_16.base03 },

    -- NvimTree paths
    NvimTreePathYellow = { bg = mix_col(M.base_30.yellow, M.base_30.darker_black, 80), fg = M.base_16.base05 },
    NvimTreePathTeal = { bg = mix_col("#4495aa", M.base_30.darker_black, 70), fg = M.base_16.base05 },
    NvimTreePathGreen = { bg = mix_col("#60aa39", M.base_30.darker_black, 70), fg = M.base_16.base05 },
    NvimTreePathDarkPurple = { bg = mix_col(M.base_30.dark_purple, M.base_30.darker_black, 70), fg = M.base_16.base05 },
  },

  nvimtree = {
    -- Folders
    NvimTreeFolderName = { fg = M.base_16.base05 },
    NvimTreeEmptyFolderName = { fg = M.base_16.base05 },
    NvimTreeOpenedFolderName = { fg = M.base_16.base05 },
    NvimTreeSymlinkFolderName = { fg = M.base_16.base05 },
    NvimTreeFolderIcon = { fg = M.base_30.folder_bg },

    NvimTreeRootFolder = { fg = M.base_16.base05, bold = true },

    NvimTreeFolderArrowOpen = { fg = M.base_30.folder_bg },
    NvimTreeFolderArrowClosed = { fg = M.base_30.grey_fg },

    -- Some
    NvimTreeEndOfBuffer = { fg = M.base_30.darker_black },
    NvimTreeNormal = { bg = M.base_30.darker_black },
    NvimTreeNormalNC = { bg = M.base_30.darker_black },
    NvimTreeCursorLine = { bg = M.base_30.black },
    NvimTreeWinSeparator = { fg = M.base_30.darker_black, bg = M.base_30.darker_black },
    NvimTreeWindowPicker = { fg = M.base_30.red, bg = M.base_30.black2 },

    -- Files
    NvimTreeSpecialFile = { fg = M.base_30.yellow, bold = true },
    NvimTreeExecFile = { bold = true },

    -- Git
    NvimTreeGitDirty = { fg = M.base_30.red },
    NvimTreeGitIgnored = { fg = M.base_30.light_grey },
    NvimTreeGitNew = { fg = M.base_30.red },
    NvimTreeGitDeleted = { fg = M.base_30.red },
    NvimTreeGitStagedIcon = { fg = M.base_30.green },
    NvimTreeGitFolderDeletedHL = { fg = M.base_16.base05, link = "" },

    -- Diagnostics
    NvimTreeDiagnosticErrorFileHL = { undercurl = true, sp = M.base_16.base08, link = "" },
    NvimTreeDiagnosticErrorFolderHL = { undercurl = true, sp = M.base_16.base08, link = "" },

    NvimTreeDiagnosticWarnFileHL = { undercurl = true, sp = M.base_16.base0A, link = "" },
    NvimTreeDiagnosticWarnFolderHL = { undercurl = true, sp = M.base_16.base0A, link = "" },

    -- Diff
    DiffAdd = { bg = mix_col(M.base_30.green, M.base_30.black, 80) },
    DiffChange = { bg = mix_col(M.base_30.yellow, M.base_30.black, 80) },
    DiffText = { bg = mix_col(M.base_30.yellow, M.base_30.black, 80) },
    DiffDelete = { bg = mix_col(M.base_30.red, M.base_30.black, 80) },
  },
  syntax = {
    Boolean = { fg = M.base_16.base05 },
    Character = { fg = M.base_16.base05 },
    Conditional = { fg = M.base_16.base05 },
    Constant = { fg = M.base_16.base05 },
    Define = { fg = M.base_16.base05 },
    Delimiter = { fg = M.base_16.base05 },
    Float = { fg = M.base_16.base05 },
    Variable = { fg = M.base_16.base05 },
    Function = { fg = M.base_16.base05 },
    Identifier = { fg = M.base_16.base05 },
    Include = { fg = M.base_16.base05 },
    Keyword = { fg = M.base_16.base05 },
    Label = { fg = M.base_16.base05 },
    Number = { fg = M.base_16.base05 },
    Operator = { fg = M.base_16.base05 },
    PreProc = { fg = M.base_16.base05 },
    Repeat = { fg = M.base_16.base05 },
    Special = { fg = M.base_16.base05 },
    SpecialChar = { fg = M.base_16.base05 },
    Statement = { fg = M.base_16.base05 },
    StorageClass = { fg = M.base_16.base05 },
    String = { fg = M.base_16.base05 },
    Structure = { fg = M.base_16.base05 },
    Tag = { fg = M.base_16.base05 },
    Todo = { fg = M.base_16.base05 },
    Type = { fg = M.base_16.base05 },
    Typedef = { fg = M.base_16.base05 },
  },

  treesitter = {
    ["@variable"] = { fg = M.base_16.base05 },
    ["@variable.builtin"] = { fg = M.base_16.base05 },
    ["@variable.parameter"] = { fg = M.base_16.base05 },
    ["@variable.member"] = { fg = M.base_16.base05 },
    ["@variable.member.key"] = { fg = M.base_16.base05 },

    ["@module"] = { fg = M.base_16.base05 },
    ["@module.builtin"] = { fg = M.base_16.base05 },

    ["@constant"] = { fg = M.base_16.base0E },
    ["@constant.builtin"] = { fg = M.base_16.base09 },
    ["@constant.macro"] = { fg = M.base_16.base0E },

    ["@string"] = { fg = M.base_16.base0B },
    ["@string.css"] = { fg = M.base_16.base05 },
    ["@string.regex"] = { fg = M.base_16.base05 },
    ["@string.escape"] = { fg = M.base_16.base05 },
    ["@string.special.url.gomod"] = { link = "" },
    ["@string.special.gomod"] = { link = "", fg = M.base_16.base0D },

    ["@character"] = { fg = M.base_16.base05 },
    ["@character.special"] = { fg = M.base_16.base05 },
    ["@character.printf"] = { fg = M.base_16.base09 },
    ["@number"] = { fg = M.base_16.base05 },
    ["@number.float"] = { fg = M.base_16.base05 },

    ["@annotation"] = { fg = M.base_16.base05 },
    ["@attribute"] = { fg = M.base_16.base05 },
    ["@error"] = { fg = M.base_16.base05 },

    ["@keyword"] = { fg = M.base_16.base09 },
    ["@keyword.json5"] = { fg = M.base_16.base05 },
    ["@keyword.function"] = { fg = M.base_16.base09 },
    ["@keyword.exception"] = { fg = M.base_16.base09 },
    ["@keyword.return"] = { fg = M.base_16.base09 },
    ["@keyword.operator"] = { fg = M.base_16.base09 },
    ["@keyword.conditional"] = { fg = M.base_16.base09 },
    ["@keyword.conditional.ternary"] = { fg = M.base_16.base09 },
    ["@keyword.repeat"] = { fg = M.base_16.base09 },
    ["@keyword.storage"] = { fg = M.base_16.base09 },
    ["@keyword.directive.define"] = { fg = M.base_16.base09 },
    ["@keyword.directive"] = { fg = M.base_16.base09 },

    ["@keyword.import"] = { fg = M.base_16.base09 },
    ["@keyword.import.go"] = { fg = M.base_16.base09 },
    ["@keyword.import.python"] = { fg = M.base_16.base09 },
    ["@keyword.import.tsx"] = { fg = M.base_16.base09 },
    ["@keyword.import.typescript"] = { fg = M.base_16.base09 },
    ["@keyword.import.javascript"] = { fg = M.base_16.base09 },
    ["@keyword.import.make"] = { fg = M.base_16.base09 },

    ["@function"] = { fg = M.base_16.base0D },
    ["@function.builtin"] = { fg = M.base_16.base0D },
    ["@function.macro"] = { fg = M.base_16.base05 },
    ["@function.call"] = { fg = M.base_16.base0C },

    ["@function.call.tsx"] = { fg = M.base_16.base0C },
    ["@function.method"] = { fg = M.base_16.base0C },
    ["@function.method.call"] = { fg = M.base_16.base0C },
    ["@constructor"] = { fg = M.base_16.base0C },
    ["@constructor.lua"] = { fg = M.base_16.base05 },

    ["@operator"] = { fg = M.base_16.base05 },
    ["@reference"] = { fg = M.base_16.base05 },
    ["@punctuation.bracket"] = { fg = M.base_16.base05 },
    ["@punctuation.delimiter"] = { fg = M.base_16.base05 },
    ["@symbol"] = { fg = M.base_16.base05 },
    ["@tag"] = { fg = M.base_16.base09 },
    ["@tag.attribute"] = { fg = M.base_16.base05 },
    ["@tag.delimiter"] = { fg = M.base_16.base05 },
    ["@text"] = { fg = M.base_16.base05 },
    ["@text.emphasis"] = { fg = M.base_16.base05 },
    ["@text.strike"] = { fg = M.base_16.base05 },
    ["@type"] = { fg = M.base_16.base0D },
    ["@type.builtin"] = { fg = M.base_16.base0A },
    ["@type.definition"] = { fg = M.base_16.base05 },
    ["@definition"] = { fg = M.base_16.base05 },
    ["@scope"] = { fg = M.base_16.base05 },
    ["@property"] = { fg = M.base_16.base05 },

    -- markup
    ["@markup.heading"] = { fg = M.base_16.base0C },
    ["@markup.raw"] = { fg = M.base_16.base05 },
    ["@markup.link"] = { fg = M.base_16.base05 },
    ["@markup.link.url"] = { fg = M.base_16.base05 },
    ["@markup.link.label"] = { fg = M.base_16.base05 },
    ["@markup.list"] = { fg = M.base_16.base05 },
    ["@markup.strong"] = { fg = M.base_16.base05 },
    ["@markup.underline"] = { fg = M.base_16.base05 },
    ["@markup.italic"] = { fg = M.base_16.base05 },
    ["@markup.strikethrough"] = { fg = M.base_16.base05 },
    ["@markup.quote"] = { fg = M.base_16.base05 },

    ["@boolean"] = { fg = M.base_16.base09 },
    ["@name"] = { fg = M.base_16.base05 },

    ["@comment"] = { fg = M.base_16.base04 },
    ["@comment.todo"] = { fg = M.base_16.base05 },
    ["@comment.warning"] = { fg = M.base_16.base05 },
    ["@comment.note"] = { fg = M.base_16.base05 },
    ["@comment.danger"] = { fg = M.base_16.base05 },

    ["@sql.queries"] = { bg = mix_col("#20A969", M.base_30.black, 87) },
  },

  statusline = {
    StatusLine = { bg = M.base_30.statusline_bg, fg = M.base_16.base05 },
    StBase = { bg = M.base_30.statusline_bg, fg = M.base_16.base05 },

    StName = { bg = M.base_30.grey, fg = M.base_30.white },
    StGitHead = { bg = M.base_30.lightbg, fg = M.base_30.white },
    StPath = { bg = M.base_30.statusline_bg, fg = M.base_16.base05 },
    StPathYellow = { bg = mix_col(M.base_30.yellow, M.base_30.statusline_bg, 80), fg = M.base_16.base05 },
    StPathTeal = { bg = mix_col("#4495aa", M.base_30.statusline_bg, 80), fg = M.base_16.base05 },
    StPathGreen = { bg = mix_col("#60aa39", M.base_30.statusline_bg, 80), fg = M.base_16.base05 },
    StPathDarkPurple = { bg = mix_col(M.base_30.dark_purple, M.base_30.statusline_bg, 80), fg = M.base_16.base05 },
    StLspMsg = { bg = M.base_30.statusline_bg, fg = M.base_30.green },
    StCursor = { bg = M.base_30.statusline_bg, fg = M.base_30.light_grey },

    -- Diagnostic highlights
    StLspError = { fg = M.base_30.red, bg = M.base_30.statusline_bg },
    StLspWarning = { fg = M.base_30.yellow, bg = M.base_30.statusline_bg },
    StLspHints = { fg = M.base_30.purple, bg = M.base_30.statusline_bg },
    StLspInfo = { fg = M.base_30.green, bg = M.base_30.statusline_bg },
  },

  cmp = {
    CmpItemMenu = { fg = M.base_16.base04 },
  },

  git = {
    DiffAdd = { fg = M.base_16.base0B },
  },

  telescope = {
    TelescopeResultsConstant = { fg = M.base_16.base0B },
    TelescopeResultsIdentifier = { fg = M.base_16.base0F },
  },
}

local function gen_stl_mode_hl(modename, col)
  M.polish_hl.statusline["StMode" .. modename] = { fg = M.base_30[col], bg = M.base_30.grey }
end

gen_stl_mode_hl("Normal", "nord_blue")
gen_stl_mode_hl("Visual", "cyan")
gen_stl_mode_hl("Insert", "dark_purple")
gen_stl_mode_hl("Terminal", "green")
gen_stl_mode_hl("NTerminal", "yellow")
gen_stl_mode_hl("Replace", "orange")
gen_stl_mode_hl("Confirm", "teal")
gen_stl_mode_hl("Command", "green")
gen_stl_mode_hl("Select", "blue")

vim.g.terminal_color_0 = M.base_16.base01 -- Dark grey
vim.g.terminal_color_1 = M.base_16.base08 -- Red
vim.g.terminal_color_2 = M.base_16.base0B -- Green
vim.g.terminal_color_3 = M.base_16.base0A -- Yellow
vim.g.terminal_color_4 = M.base_16.base0D -- Blue
vim.g.terminal_color_5 = M.base_16.base0E -- Purple
vim.g.terminal_color_6 = M.base_16.base0C -- Cyan
vim.g.terminal_color_7 = M.base_16.base05 -- White

vim.g.terminal_color_8 = M.base_16.base03
vim.g.terminal_color_9 = M.base_16.base08
vim.g.terminal_color_10 = M.base_16.base0B
vim.g.terminal_color_11 = M.base_16.base0A
vim.g.terminal_color_12 = M.base_16.base0D
vim.g.terminal_color_13 = M.base_16.base0E
vim.g.terminal_color_14 = M.base_16.base0C
vim.g.terminal_color_15 = M.base_16.base07

return M
