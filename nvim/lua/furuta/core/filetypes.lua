-- Custom filetype detection

-- .htaccess.* files should be recognized as Apache configuration files
vim.filetype.add({
  pattern = {
    ["%.htaccess%..*"] = "apacheconf",
  },
})
