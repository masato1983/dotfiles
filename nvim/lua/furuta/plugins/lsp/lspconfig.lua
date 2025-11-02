return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1 })
      end, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1 })
      end, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    local x = vim.diagnostic.severity

    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
      },
      signs = { text = { [x.ERROR] = " ", [x.WARN] = " ", [x.HINT] = "󰠠 ", [x.INFO] = " " } },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = on_attach,
    })

    vim.lsp.config("stylelint_lsp", {
      filetypes = { "scss" },
      settings = {
        ["autoFixOnSave"] = true,
      },
    })

    vim.lsp.config("eslint", {
      filetypes = { "javascript", "typescript" },
    })

    vim.lsp.config("ts_ls", {
      filetypes = { "typescript" },
    })

    vim.lsp.config("jsonls", {
      filetypes = { "json" },
    })

    vim.lsp.config("emmet_language_server", {
      filetypes = { "html", "php", "css", "scss" },
      init_options = { extensionsPath = { vim.fn.getcwd() .. "/" } },
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    vim.lsp.enable({
      "html",
      "intelephense",
      "cssls",
      "css_variables",
      "somesass_ls",
      "stylelint_lsp",
      "eslint",
      "ts_ls",
      "jsonls",
      "emmet_language_server",
      "lua_ls",
    })
  end,
}
