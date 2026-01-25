return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufWritePre" },
  opts = {},
  config = function()
    local conform = require("conform")

    local default_config = {
      formatters_by_ft = {
        sh = { "shfmt" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        css = { "prettier", "stylelint" },
        scss = { "prettier", "stylelint" },
        html = { "prettier" },
        php = { "php_cs_fixer" },
        json = { "eslint_d" },
        jsonc = { "eslint_d" },
        yaml = { "prettier" },
        markdown = { "eslint_d" },
        mdx = { "prettier" },
        lua = { "stylua" },
        xml = { "prettier" },
      },
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 2000,
      },
    }

    local function find_project_root()
      local current_file_dir = vim.api.nvim_buf_get_name(0)

      if current_file_dir == "" then
        return nil
      end

      current_file_dir = vim.fs.dirname(current_file_dir)

      -- First, try to find .git directory (monorepo root)
      local git_root = vim.fs.find(".git", { path = current_file_dir, upward = true })

      if #git_root > 0 then
        local root = vim.fs.dirname(git_root[1])
        local nvim_config = root .. "/.nvim/conform.json"

        -- Check if .nvim/conform.json exists at git root
        if vim.fn.filereadable(nvim_config) == 1 then
          return root
        end
      end

      -- Fallback to nearest package root for non-monorepo or nested projects
      local root_markers = { "package.json", "composer.json", "init.lua" }
      local found_markers = vim.fs.find(root_markers, { path = current_file_dir, upward = true })

      if #found_markers > 0 then
        return vim.fs.dirname(found_markers[1])
      end

      return nil
    end

    local final_config = (function()
      local project_root = find_project_root()

      if not project_root then
        return default_config
      end

      local conform_json_path = project_root .. "/.nvim/conform.json"
      local json_file = io.open(conform_json_path, "r")

      if json_file then
        local content = json_file:read("*a")

        io.close(json_file)

        local ok, local_config = pcall(vim.fn.json_decode, content)

        if ok then
          print("Loaded project-specific conform config from: " .. conform_json_path)
          return vim.tbl_deep_extend("force", default_config, local_config)
        else
          vim.notify("Error parsing .nvim/.conform.json: " .. tostring(local_config), vim.log.levels.ERROR)
        end
      end

      return default_config
    end)()

    conform.setup(final_config)
  end,
}
