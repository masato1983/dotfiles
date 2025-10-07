-- Custom filetype detection

-- .htaccess.* files should be recognized as Apache configuration files
vim.filetype.add({
  pattern = {
    ["%.htaccess%..*"] = "apache",
  },
})

-- *.php.* files should be recognized as PHP files
vim.filetype.add({
  pattern = {
    [".*%.php%..*"] = "php",
  },
})
