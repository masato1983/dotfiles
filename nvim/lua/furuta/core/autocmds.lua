-- markdown ファイル用
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "mdx" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- 空バッファ用（起動直後 + 新規作成時）
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
  callback = function()
    if vim.bo.filetype == "" then
      vim.opt_local.wrap = true
    end
  end,
})

-- プロジェクトローカルの設定ファイルを読み込む
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  pattern = "*",
  desc = "Load project-local config file if it exists",
  callback = function()
    local local_config = vim.fn.findfile(".nvim/autocmds.lua", ".;")

    if local_config and local_config ~= "" then
      dofile(local_config)
    end
  end,
})
