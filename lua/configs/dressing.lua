return {
  input = {
    title_pos = "center",
    border = "single",
    override = function(conf)
      if conf.title == " New Name " then
        conf.title = " Rename to "
      end
      return conf
    end,
  },
}
