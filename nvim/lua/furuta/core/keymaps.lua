-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- 行連結時のカーソル移動を無効化
keymap.set("n", "gJ", "mzJ`z")
keymap.set("n", "J", "mzgJ`z")

-- 折り返しを無視した行移動
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

-- 行末までヤンク
keymap.set("n", "<leader>y", "^y$")

-- ファイル名/パスをコピー (nvim-tree と統一)
keymap.set("n", "<leader>y", function()
  local name = vim.fn.expand("%:t")
  vim.fn.setreg("+", name)
  vim.notify("Copied: " .. name)
end, { desc = "Copy filename" })

keymap.set("n", "<leader>Y", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy relative path" })

keymap.set("n", "<leader>gy", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy absolute path" })

keymap.set("n", "<leader>ge", function()
  local basename = vim.fn.expand("%:t:r")
  vim.fn.setreg("+", basename)
  vim.notify("Copied: " .. basename)
end, { desc = "Copy basename (no extension)" })

keymap.set("n", "<leader>gY", function()
  local path = "@" .. vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy absolute path with @ prefix" })

keymap.set("n", "<leader>gm", function()
  local filepath = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n")
  local markdown = filepath .. "\n\n```" .. ext .. "\n" .. content .. "\n```\n\n"
  vim.fn.setreg("+", markdown)
  vim.notify("Copied to clipboard: " .. filepath)
end, { desc = "Copy file with markdown format" })

-- 全角英数字を半角に変換
keymap.set("n", "<leader>zh", [[:%s/[０-９Ａ-Ｚａ-ｚ]/\=nr2char(char2nr(submatch(0))-65248)/ge<CR>]])
keymap.set("x", "<leader>zh", [[:s/[０-９Ａ-Ｚａ-ｚ]/\=nr2char(char2nr(submatch(0))-65248)/ge<CR>]])

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
-- resize vertical splits (decrease/increase width)
keymap.set("n", "<leader>wh", ":vertical resize -20<CR>")
keymap.set("n", "<leader>wl", ":vertical resize +20<CR>")

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- 矩形選択、行選択、全選択
keymap.set("x", ".", "<ESC>ggVG")
keymap.set("x", "v", "<C-v>")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
