local map = vim.keymap.set

-- <! Base
map("i", "jk", "<ESC>")

map("n", "<C-a>", "ggVG")

map({ "n", "v" }, ";", ":", { desc = "Cmd enter command mode" })

map("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Window quit" })
map("n", "<C-q>", "<cmd>confirm qall<CR>", { desc = "General quit neovim" })

map("n", "<C-`>", "<cmd>noh<CR>", { desc = "Clear highlights" })
map("n", "q:", "", { desc = "Disable commands history" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

map("n", "n", "nzz", { desc = "Go to next search result" })
map("n", "N", "Nzz", { desc = "Go to prev search result" })

map("n", "zo", "za", { desc = "Toggle fold" })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Base !>

-- <! Movements in insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })
-- Movements in insert mode !>

-- <! Cut & delete
map({ "n", "v" }, "c", '"pc')
map({ "n", "v" }, "C", '"pC')

map({ "n", "v" }, "d", '"pd')
map({ "n", "v" }, "D", '"pD')

map("n", "x", '"_x')
map("n", "X", '"_X')

map("n", "<leader>p", '"pp')
map("n", "<leader>P", '"pP')

map("v", "p", '"_dP')

map("v", "<BS>", '"_d', { noremap = true })

map("i", "<C-p>", '<esc>"ppi', { noremap = true })

map("n", "<C-d>", '"zY"zp', { desc = "Duplicate line" })
-- Cut & delete !>

-- <! Scroll
local keymap = {
  ["<A-k>"] = function()
    require("neoscroll").scroll(-0.1, { move_cursor = false, duration = 100 })
  end,
  ["<A-j>"] = function()
    require("neoscroll").scroll(0.1, { move_cursor = false, duration = 100 })
  end,
}
for key, func in pairs(keymap) do
  map({ "n", "v", "x" }, key, func)
end
-- Scroll !>

-- <! Buffers
map("n", "<leader>n", "<cmd>enew<CR>", { desc = "Buffer new" })

map("n", "<C-;>", "<cmd>e #<CR>", { desc = "Buffer alternative" })

map("n", "]b", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer goto next" })

map("n", "[b", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer goto prev" })

map("n", "<leader>c", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer close" })

-- TODO: 2025-08-09 test
map("n", "<leader>b", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Buffer close all" })

-- map("n", "<leader>bc", function()
--   require("Yu-Leo.buffers").close_all_hidden()
-- end, { desc = "Buffer close all hidden" })

map("n", ">b", function()
  require("nvchad.tabufline").move_buf(1)
end, { desc = "Buffer move right" })

map("n", "<b", function()
  require("nvchad.tabufline").move_buf(-1)
end, { desc = "Buffer move left" })
-- Buffers !>

-- <! Windows
map("n", "|", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "\\", "<cmd>split<CR>", { desc = "Split horizontal" })

map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

map("n", "<A-S-h>", "<C-w>h<cmd>confirm q<CR>", { desc = "Close window left" })
map("n", "<A-S-l>", "<C-w>l<cmd>confirm q<CR>", { desc = "Close window right" })
map("n", "<A-S-j>", "<C-w>j<cmd>confirm q<CR>", { desc = "Close window down" })
map("n", "<A-S-k>", "<C-w>k<cmd>confirm q<CR>", { desc = "Close window up" })

map("n", "<A-S-u>", "<C-w>x", { desc = "Switch windows" })

map("n", "<C-A-j>", "<Cmd>resize -2<CR>", { desc = "Resize window up" })
map("n", "<C-A-k>", "<Cmd>resize +2<CR>", { desc = "Resize window down" })
map("n", "<C-A-h>", "<Cmd>vertical resize -2<CR>", { desc = "Resize window left" })
map("n", "<C-A-l>", "<Cmd>vertical resize +2<CR>", { desc = "Resize window right" })

-- Close all floating windows
map("n", "<Esc>", function()
  vim.cmd "noh"
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, true)
    end
  end
end, { noremap = true, silent = true })
-- Windows !>

-- <! Tabs
map("n", "]t", function()
  vim.cmd.tabnext()
end, { desc = "Tab goto next" })

map("n", "[t", function()
  vim.cmd.tabprevious()
end, { desc = "Tab goto prev" })

map("n", "<leader>tn", function()
  vim.cmd.tabnew()
end, { desc = "Tab new" })

map("n", "<leader>tc", function()
  pcall(vim.cmd, "tabclose")
end, { desc = "Tab close" })
-- Tabs !>

-- <! NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle window" })

map("n", "<Leader>sf", function()
  require("nvim-tree.api").tree.open { find_file = true, update_root = true }
end, { desc = "Nvimtree show file" })
-- NvimTree !>

-- <! Flash
map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Jump to symbols" })

map({ "n", "x", "o" }, "S", function()
  require("flash").jump {
    search = {
      mode = "search",
      max_length = 0,
    },
    label = { after = { 0, 0 } },
    pattern = "^$",
  }
end, { desc = "Jump to empty lines" })
-- Flash !>

-- <! Telescope
map("n", "<leader>F", function()
  require("telescope").extensions["recent-files"].recent_files {}
end, { desc = "Telescope find files" })

map("n", "<leader>fw", function()
  require("telescope.builtin").live_grep {
    additional_args = {
      "-F",
      "-S",
      "--hidden",
      "--no-ignore",
    },
  }
end, { desc = "Telescope find words" })

map("n", "<leader>fo", function()
  require("snipe").open_buffer_menu()
end, { desc = "Find open buffers" })

map("n", "<leader>fh", function()
  require("telescope.builtin").grep_string {
    search = "TODO",
    additional_args = function()
      return { "-i" }
    end,
  }
end, { desc = "Find todos" })

map("n", "<leader>fm", function()
  require("telescope").extensions.git_file_history.git_file_history()
end, { desc = "File browser" })

map("n", "<leader>f<CR>", function()
  require("telescope.builtin").resume()
end, { desc = "Telescope resume resent search" })

map("n", "<leader>gco", function()
  require("telescope.builtin").git_branches { use_file_path = true }
end, { desc = "Telescope git branches" })
-- Telescope !>

-- <! Terminal
map("t", "<ESC>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })

map({ "n", "t" }, "<M-h>", "<cmd>ToggleTerm<CR>", { desc = "Toggle horizontal terminal" })
map({ "n", "t" }, "<M-H>", "<cmd>ToggleTerm dir=%:p:h<CR>", { desc = "Toggle horizontal terminal in file's directory" })
-- Terminal !>

-- <! Git
map("n", "<leader>ga", "<cmd>Git add --all<CR>", { desc = "Git add to index all" })
map("n", "<leader>gst", "<cmd>Git status<CR>", { desc = "Git status" })

map("n", "<leader>gy", "<cmd>Git commit --amend<CR>", { desc = "Git commit --amend" })

map("n", "<leader>gm", function()
  require("Yu-Leo.git").git_commit()
end, { desc = "Git commit" })

map("n", "<leader>gj", function()
  require("Yu-Leo.git").git_commit "task"
end, { desc = "Git commit with git task name prefix" })

map("n", "<leader>gM", function()
  require("Yu-Leo.git").git_stage_and_commit()
end, { desc = "Git stage all & commit" })

map("n", "<leader>gJ", function()
  require("Yu-Leo.git").git_stage_and_commit "task"
end, { desc = "Git stage all & commit with git task name prefix" })

map("n", "<leader>gi", "<cmd>Git push<CR>", { desc = "Git push" })

map("n", "<leader>gps", function()
  require("Yu-Leo.git").git_push_set_upstream()
end, { desc = "Git push --set-upstream origin <branch-name>" })

map("n", "<leader>gpf", "<cmd>Git push --force<CR>", { desc = "Git push --force" })

map("n", "<leader>gpr", "<cmd>Git pull --rebase<CR>", { desc = "Git pull with rebase" })

map("n", "<leader>gka", "<cmd>Git restore .<CR>", { desc = "Git restore ." })
map("n", "<leader>gkd", "<cmd>Git restore %<CR>", { desc = "Git restore file" })
map("n", "<leader>gkf", "<cmd>Git reset --hard HEAD<CR>", { desc = "Git reset --hard HEAD" })

map("n", "<leader>gcb", function()
  require("Yu-Leo.git").git_checkout_branch()
end, { desc = "Git checkout branch" })

map("n", "<leader>gsw", function()
  require("Yu-Leo.git").git_switch_branch()
end, { desc = "Git switch" })

map("n", "<leader>ghf", "<cmd>DiffviewFileHistory %<CR>", { desc = "Git: open file history" })

map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git: open Diffview" })
map("n", "<leader>gD", function()
  vim.api.nvim_feedkeys(":DiffviewOpen", "n", false)
end, { desc = "Git: open Diffview with params" })

map("n", "<leader>gl", function()
  require("blame-column").toggle()
end, { desc = "Git toggle blame" })

map("n", "<leader>gu", function()
  require("Yu-Leo.git").git_checkout_main_and_update()
end, { desc = "Git checkout main and update" })

map("n", "<leader>gz", function()
  require("Yu-Leo.git").git_rebase_main()
end, { desc = "Git rebase main" })

map("n", "<leader>gZ", function()
  vim.cmd "G rebase --continue"
end, { desc = "Git rebabse --continue" })

map("n", "<leader>go", function()
  require("Yu-Leo.git").git_merge_main()
end, { desc = "Git merge main" })

map("n", "<leader>gO", function()
  vim.cmd "G merge --continue"
end, { desc = "Git merge --continue" })

-- Navigation
map("n", "]h", function()
  if vim.wo.diff then
    vim.cmd.normal { "]h", bang = true }
  else
    require("gitsigns").nav_hunk "next"
  end
end, { desc = "Go to next git hunk" })

map("n", "[h", function()
  if vim.wo.diff then
    vim.cmd.normal { "[h", bang = true }
  else
    require("gitsigns").nav_hunk "prev"
  end
end, { desc = "Go to prev git hunk" })

map("n", "<leader>ghs", require("gitsigns").preview_hunk, { desc = "Git signs: preview hunk" })
-- Git !>

-- <! Sessions
map("n", "<leader>sr", function()
  require("persistence").load()
end, { desc = "Session restore" })
-- Sessions !>

-- <! Neotest
map("n", "<leader>T", function()
  require("neotest").run.run()
end, { desc = "Run nearest test" })

map("n", "<leader>tm", function()
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Run tests in file" })

map("n", "<leader>tp", function()
  require("neotest").run.run(vim.fn.getcwd())
end, { desc = "Run tests in project" })

map("n", "<leader>tl", function()
  require("neotest").run.run_last()
end, { desc = "Run last test" })

map("n", "<leader>to", "<cmd>Neotest output<CR>", { desc = "Neotest output" })
map("n", "<leader>ts", "<cmd>Neotest summary<CR>", { desc = "Neotest summary" })

map("n", "[e", "<cmd>lua require('neotest').jump.prev({status = 'failed'})<CR>", { desc = "Run previous failed test" })
map("n", "]e", "<cmd>lua require('neotest').jump.next({status = 'failed'})<CR>", { desc = "Run next failed test" })
-- Neotest !>

-- <! Double leader
map("n", "<leader><leader>c", function()
  vim.opt_local.spell = not (vim.opt_local.spell:get())
  vim.notify("spell: " .. tostring(vim.o.spell))
end, { desc = "Toggle spell check" })

map("n", "<leader><leader>n", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative number" })

map("n", "<leader><leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle line wraps", remap = true })

map("n", "<leader><leader>s", "<cmd>TSContextToggle<cr>", { desc = "Toggle TS context", remap = true })

map("n", "<leader><leader>v", "<cmd>TSPlaygroundToggle<CR>", { desc = "Toggle TS Playground", remap = true })

map("n", "<leader><leader>t", function()
  -- Mapping for some tests
end, { desc = "TODO", remap = true })
-- Double leader !>

-- <! Some
map("n", "<leader>vo", function()
  local start_line = vim.fn.line "."
  local bufnr = vim.api.nvim_get_current_buf()
  local total_lines = vim.api.nvim_buf_line_count(bufnr)

  local function is_comment(line_nr)
    local line = vim.fn.getline(line_nr)
    return line:match "^%s*//" ~= nil
  end

  local top = start_line
  while top > 1 and is_comment(top - 1) do
    top = top - 1
  end

  local bottom = start_line
  while bottom < total_lines and is_comment(bottom + 1) do
    bottom = bottom + 1
  end

  vim.cmd(tostring(top))
  vim.cmd "normal! V"
  vim.cmd(tostring(bottom))
end, { desc = "Select commented lines around", remap = true })

map("n", "mp", "ysiW(lxh%Xi, ", { desc = "Add return param (Go) after", remap = true })
map("n", "mP", "ysiW(%X%a", { desc = "Add return param (Go) before", remap = true })
map("n", "<leader>ti", "A // TODO: ", { desc = "Add TODO comment", remap = true })
map("n", "<leader>;", "mqA;<Esc>`q", { desc = "Add ; to end of line", remap = true })

map("n", "mf", function()
  require("Yu-Leo.moves").move_to_func_name()
end, { desc = "Move to func name (golang)", remap = true })

map("n", "<leader>fl", "<cmd>copen<CR>", { desc = "Open quickfix" })

map({ "n", "v" }, "<leader>r", function()
  Snacks.gitbrowse.open()
end, { desc = "Open remote repo in browser" })

map("n", "<leader>R", "<cmd>GitPortal open_link<CR>", { desc = "Open link in neovim" })

map("n", "<leader>lf", function()
  require("conform").format()
end, { desc = "Format file", remap = true })

map("n", "<leader>lw", "<cmd>GoFillStruct<CR>", { desc = "Go fill struct", remap = true })
map("n", "<leader>lg", "<cmd>GoGenerate<CR>", { desc = "Go generate for file", remap = true })
map("n", "<leader>lu", "<cmd>GoModTidy<CR>", { desc = "Go mod tidy", remap = true })
map("n", "<leader>li", "<cmd>GoModVendor<CR>", { desc = "Go mod vendor", remap = true })
map("n", "<leader>lt", function()
  require("go.lsp").codeaction { cmd = "apply_fix", only = "refactor.rewrite", filters = { "split_lines" } }
end, { desc = "Go split lines", remap = true })
map("n", "<leader>lT", function()
  require("go.lsp").codeaction { cmd = "apply_fix", only = "refactor.rewrite", filters = { "join_lines" } }
end, { desc = "Go join lines", remap = true })

map("n", "<leader>le", "<cmd>e<CR>", { desc = "LSP restart", remap = true })

map("n", "<leader>os", function()
  require("simple-boolean-toggle").toggle()
end, { desc = "Toggle boolean value" })

map("n", "<leader>/", "gcc", { desc = "Comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "Comment toggle", remap = true })

map("n", "<leader>ot", require("Yu-Leo.common").go_to_test_file, { desc = "go to test" })

map("n", "[<Space>", "m`O<Esc>``", { desc = "Insert empty line above" })
map("n", "]<Space>", "m`o<Esc>``", { desc = "Insert empty line bellow" })

map("n", "<leader>V", function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    print "enable autoformat"
  else
    vim.g.disable_autoformat = true
    print "disable autoformat"
  end
  vim.cmd.redrawstatus()
end, { desc = "Toggle autoformat on save", remap = true })

map("n", "<leader>L", ":Lazy<CR>", { desc = "Open Lazy" })
-- Some !>
