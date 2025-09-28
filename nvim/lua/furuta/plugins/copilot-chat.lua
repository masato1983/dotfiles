return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    opts = {
      prompts = {
        Commit = {
          prompt = "Write commit message for the change with commitizen convention in English. Keep the title under 50 characters. Format as a gitcommit code block.",
          resources = {
            "gitdiff:staged",
          },
          description = "Write commit message for staged changes",
        },
      },
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)

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
      })
    end,
  },
}
