return {
  "ntpeters/vim-better-whitespace",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "]w", "<cmd>NextTrailingWhitespace<CR>", desc = "Next trailing whitespace" },
    { "[w", "<cmd>PrevTrailingWhitespace<CR>", desc = "Previous trailing whitespace" },
    { "<leader>sw", "<cmd>StripWhitespace<CR>", desc = "Strip whitespace" },
  },
  config = function()
    local function apply()
      vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#f38ba8" })
    end

    apply()

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("BetterWhitespaceColor", { clear = true }),
      callback = apply,
    })
  end,
}
