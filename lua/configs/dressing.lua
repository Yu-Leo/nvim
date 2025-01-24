return {
  input = {
    title_pos = "center",
    border = "single",
    override = function(conf)
      -- The same titles for renamer in nvim-tree and renamer for lsp
      if conf.title == " New Name " then
        conf.title = " Rename to "
      end
      return conf
    end,
  },
}
