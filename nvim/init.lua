print("Hello nvim")

if vim.g.vscode then
  -- このブロック内は、VSCode の拡張機能である
  -- Vim でのみ実行される Lua のコードになります。

  -- 折り返しを無視した行移動
  vim.keymap.set("n", "J", "mzJ`z")
  vim.keymap.set("n", "gJ", "mzgJ`z")

  -- 折り返しを無視した行移動
  vim.keymap.set("n", "j", "gj")
  vim.keymap.set("n", "k", "gk")

  -- 矩形選択、行選択、全選択
  vim.keymap.set("x", ".", "<ESC>ggVG")
  vim.keymap.set("x", "v", "<C-v>")

  -- クリップボードの有効化
  vim.opt.clipboard = "unnamedplus"

  -- Markdonw ファイル時に wrap を有効にします。
  vim.cmd("autocmd FileType markdown setlocal wrap")
else
  require("furuta.core")
  require("furuta.lazy")
end
