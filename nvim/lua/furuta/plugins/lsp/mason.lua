return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "bashls",
        "html",
        "twiggy_language_server",
        "intelephense",
        "copilot_language_server",
        "cssls",
        "css_variables",
        "somesass_ls",
        "stylelint_lsp",
        "eslint",
        "ts_ls",
        "lua_ls",
        "jsonls",
        "emmet_language_server",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "stylelint", -- scss linter
        "eslint", -- eslint linter
        "markdownlint-cli2", -- markdown linter
      },
    })
  end,
}
