return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  config = function()
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    require("render-markdown").setup({
      enabled = true,

      keymap.set("n", "<leader>rm", ":RenderMarkdown toggle<CR>", opts),
    })
  end,
}
