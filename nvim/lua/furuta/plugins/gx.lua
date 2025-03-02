return {
  "chrishrb/gx.nvim",
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  event = { "BufEnter" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
}
