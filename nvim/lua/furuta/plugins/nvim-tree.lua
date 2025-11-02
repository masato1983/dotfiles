return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- ファイル名と中身をマークダウン形式でコピーする関数
    local function copy_file_with_markdown()
      local api = require("nvim-tree.api")
      local node = api.tree.get_node_under_cursor()

      if not node or node.type == "directory" then
        vim.notify("Please select a file", vim.log.levels.WARN)
        return
      end

      local filepath = node.absolute_path
      local file = io.open(filepath, "r")

      if not file then
        vim.notify("Could not read file: " .. filepath, vim.log.levels.ERROR)
        return
      end

      local content = file:read("*all")
      file:close()

      -- ファイル拡張子を取得
      local ext = filepath:match("^.+%.(.+)$") or ""

      -- マークダウン形式で整形
      local markdown = filepath .. "\n\n```" .. ext .. "\n" .. content .. "\n```"

      -- クリップボードにコピー
      vim.fn.setreg("+", markdown)
      vim.notify("Copied to clipboard: " .. filepath, vim.log.levels.INFO)
    end

    -- カスタムマッピング用の関数
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- デフォルトマッピングを適用
      api.config.mappings.default_on_attach(bufnr)

      -- カスタムマッピングを追加
      vim.keymap.set("n", "gm", copy_file_with_markdown, opts("Copy file with markdown format"))
    end

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 40,
        side = "right",
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
      -- カスタムマッピングを設定
      on_attach = my_on_attach,
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>em", "<cmd>NvimTreeFocus<CR>", { desc = "" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
