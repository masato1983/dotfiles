return {
  "ntpeters/vim-better-whitespace",
  event = { "BufReadPre", "BufNewFile" },
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
