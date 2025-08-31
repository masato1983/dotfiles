return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufWritePre" }, -- to disable, comment this out
  config = function()
    local conform = require("conform")

    local function get_formatters()
      local project_config = vim.fn.findfile(".conform.json", ".;")
      if project_config ~= "" then
        local config_content = table.concat(vim.fn.readfile(project_config), "\n")
        local ok, config = pcall(vim.fn.json_decode, config_content)
        if ok and config.formatters_by_ft then
          return config.formatters_by_ft
        end
      end
      return {
        sh = { "shfmt" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier", "stylelint" },
        scss = { "prettier", "stylelint" },
        php = { "php_cs_fixer" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        mdx = { "prettier" },
        lua = { "stylua" },
        xml = { "prettier" },
      }
    end

    conform.setup({
      formatters_by_ft = get_formatters(),
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 2000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
