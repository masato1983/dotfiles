return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    local keymap = vim.keymap

    keymap.set("n", "<leader>hm", function()
      harpoon:list():add()
    end)

    keymap.set("n", "<leader>hl", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    keymap.set("n", "<leader>h1", function()
      harpoon:list():select(1)
    end)

    keymap.set("n", "<leader>h2", function()
      harpoon:list():select(2)
    end)

    keymap.set("n", "<leader>hp", function()
      harpoon:list():prev()
    end)

    keymap.set("n", "<leader>hn", function()
      harpoon:list():next()
    end)
  end,
}
