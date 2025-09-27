return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    opts = {
      modle = "gpt-5 mini",
      window = {
        layout = "vertical",
        width = 0.5,
      },
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "gitcommit",
        callback = function()
          vim.keymap.set(
            "n",
            "<leader>cc",
            "<cmd>CopilotChatCommit<cr>",
            { desc = "Generate Commit Message (CopilotChat)" }
          )
        end,
      }),
    },
  },
}
