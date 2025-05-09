local opt = vim.opt
local o = vim.o
local g = vim.g

o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = {
  eob = " ",
  fold = "-",
  foldclose = "▶",
  foldopen = "▼",
  foldsep = " ",
}

o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

o.quickfixtextfunc = [[{info -> v:lua.require('Yu-Leo.qf').qftf(info)}]]

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

o.diffopt = "vertical,internal,filler,closeoff,linematch:40"

-- -------------------------------------------------------------------------------------------------

opt.fileformats = "unix,dos,mac"

opt.list = true
opt.listchars = {
  tab = "› ",
  trail = "-",
  extends = ">",
  precedes = "<",
  eol = "¬",
  space = "·",
}

o.statusline = "%!v:lua.require('Yu-Leo.statusline').generate()"

vim.filetype.add {
  extension = {
    brief = "brief",
    curl = "curl",
    http = "http",
  },
}

vim.filetype.add {
  pattern = {
    [".*%.env.*"] = "sh",
  },
}

-- Spelling
-- opt.spelllang = "ru_ru,en_us"
-- opt.spell = false
-- opt.spellfile = vim.fn.expand "~/.config/nvim/spell/custom.utf-8.add"

-- Variables
g.disable_autoformat = false

o.commentstring = "// %s"

-- ---------------------

vim.o.foldcolumn = "0"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
