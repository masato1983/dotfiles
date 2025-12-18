return {
  "folke/neoconf.nvim",
  lazy = false,
  priority = 1000, -- Load before lspconfig
  opts = {
    -- Import settings from other plugins/editors
    import = {
      vscode = true, -- Import .vscode/settings.json
      coc = false,
      nlsp = false,
    },
    -- Live reload settings
    live_reload = true,
    -- File patterns for local settings
    local_settings = ".neoconf.json",
    global_settings = "neoconf.json",
  },
}
