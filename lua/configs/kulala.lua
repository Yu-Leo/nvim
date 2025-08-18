return {
  -- additional_curl_options = { "-i" },
  ui = {
    show_request_summary = false,
    disable_news_popup = true,
    default_view = "headers_body",
    show_icons = false,
    winbar = false,
    default_winbar_panes = {},
    lua_syntax_hl = false,
  },
  syntax_hl = {
    ["@punctuation.bracket.kulala_http"] = "Number",
    ["@character.special.kulala_http"] = "Special",
    ["@operator.kulala_http"] = "Special",
    ["@variable.kulala_http"] = "String",
  },
  global_keymaps = {
    ["Send request <cr>"] = {
      "<CR>",
      function()
        require("kulala").run()
      end,
      mode = { "n", "v" },
      ft = { "http", "rest" },
    },
    ["Select environment"] = {
      "e",
      function()
        require("kulala").set_selected_env()
      end,
      ft = { "http", "rest" },
    },
    ["Copy as cURL"] = {
      "c",
      function()
        require("kulala").copy()
      end,
      ft = { "http", "rest" },
    },
    ["Paste from curl"] = {
      "C",
      function()
        require("kulala").from_curl()
      end,
      ft = { "http", "rest" },
    },
    ["Open scratchpad"] = false,
    ["Open kulala"] = false,
    ["Toggle headers/body"] = false,
    ["Show stats"] = false,
    ["Close window"] = false,
    ["Send request"] = false,
    ["Send all requests"] = false,
    ["Inspect current request"] = false,
    ["Replay the last request"] = false,
    ["Find request"] = false,
    ["Jump to next request"] = false,
    ["Jump to previous request"] = false,
    ["Manage Auth Config"] = false,
    ["Download GraphQL schema"] = false,
    ["Clear globals"] = false,
    ["Clear cached files"] = false,
  },
  kulala_keymaps = false,
}
