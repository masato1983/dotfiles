return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local config = require("telescope.config")
    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
    local keymap = vim.keymap

    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("harpoon")

    -- File Pickers
    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Lists files in your current working directory, respects .gitignore" })
    keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Fuzzy search through the output of git ls-files command, respects .gitignore" })
    keymap.set("n", "<leader>gs", builtin.grep_string, { desc = "Searches for the string under your cursor or selection in your current working directory" })
    keymap.set(
      "n",
      "<leader>lg",
      builtin.live_grep,
      { desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore." }
    )

    -- Git Pickers
    keymap.set(
      "n",
      "<leader>gc",
      builtin.git_commits,
      { desc = "Lists git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h" }
    )
    keymap.set("n", "<leader>gb", builtin.git_bcommits, { desc = "Lists buffer's git commits with diff preview and checks them out on <cr>" })
    keymap.set("n", "<leader>gr", builtin.git_bcommits_range, {
      desc = "Lists buffer's git commits in a range of lines. Use options from and to to specify the range. In visual mode, lists commits for the selected lines",
    })
    keymap.set("n", "<leader>gB", builtin.git_branches, {
      desc = "Lists all branches with log preview, checkout action <cr>, track action <C-t>, rebase action<C-r>, create action <C-a>, switch action <C-s>, delete action <C-d> and merge action <C-y>",
    })
    keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Lists current changes per file with diff preview and add action. (Multi-selection still WIP)" })
    keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "Lists stash items in current repository with ability to apply them on <cr>" })
  end,
}
