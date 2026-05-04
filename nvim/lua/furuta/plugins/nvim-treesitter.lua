return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local parsers = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "twig",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "vimdoc",
        "dockerfile",
        "gitignore",
        "query",
        "regex",
        "python",
        "php",
        "mermaid",
      }

      local treesitter = require("nvim-treesitter")

      treesitter.setup()

      if type(treesitter.install) == "function" then
        treesitter.install(parsers)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("furuta_treesitter", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      require("nvim-ts-autotag").setup()

      vim.keymap.set("n", "<C-space>", "van", { desc = "Select treesitter node" })
      vim.keymap.set("x", "<C-space>", "an", { desc = "Expand treesitter selection" })
      vim.keymap.set("x", "<bs>", "in", { desc = "Shrink treesitter selection" })
    end,
  },
}
