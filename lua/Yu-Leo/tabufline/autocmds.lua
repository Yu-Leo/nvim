local api = vim.api
local get_opt = api.nvim_get_option_value
local cur_buf = api.nvim_get_current_buf
local autocmd = vim.api.nvim_create_autocmd

vim.t.bufs = vim.t.bufs
  or vim.tbl_filter(function(buf)
    return vim.fn.buflisted(buf) == 1
  end, vim.api.nvim_list_bufs())

autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
  callback = function(args)
    local bufs = vim.t.bufs
    local is_curbuf = cur_buf() == args.buf

    if bufs == nil then
      bufs = cur_buf() == args.buf and {} or { args.buf }
    else
      -- check for duplicates
      if
        not vim.tbl_contains(bufs, args.buf)
        and (args.event == "BufEnter" or not is_curbuf or get_opt("buflisted", { buf = args.buf }))
        and api.nvim_buf_is_valid(args.buf)
        and get_opt("buflisted", { buf = args.buf })
      then
        table.insert(bufs, args.buf)
      end
    end

    -- remove unnamed buffer which isnt current buf & modified
    if args.event == "BufAdd" then
      if #api.nvim_buf_get_name(bufs[1]) == 0 and not get_opt("modified", { buf = bufs[1] }) then
        table.remove(bufs, 1)
      end
    end

    vim.t.bufs = bufs
  end,
})

autocmd("BufDelete", {
  callback = function(args)
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
  end,
})

vim.o.showtabline = 2
vim.o.tabline = "%!v:lua.require('Yu-Leo.tabufline.modules')()"
dofile(vim.g.base46_cache .. "tbline")

autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
