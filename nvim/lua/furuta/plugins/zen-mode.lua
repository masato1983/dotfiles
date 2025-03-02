return {
  -- https://github.com/folke/zen-mode.nvim
  "folke/zen-mode.nvim",
  opts = {},
  window = {
    width = 120,
    height = 1,
    options = {
      signcolumn = "no",
      number = true,
      relativenumber = true,
      cursorline = false,
      cursorcolumn = false,
      foldcolumn = "0",
      list = false,
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false,
      showcmd = false,
      laststatus = 0,
    },
    twilight = { enabled = true },
    gitsigns = { enabled = false },
    tmux = { enabled = true },
  },
}
