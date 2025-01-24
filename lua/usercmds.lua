local usercmd = vim.api.nvim_create_user_command

usercmd("RTS", ":%s/\\s\\+$//", { desc = "remove trailing spaces" })
