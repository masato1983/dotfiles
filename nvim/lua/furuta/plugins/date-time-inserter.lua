return {
  "AntonVanAssche/date-time-inserter.nvim",
  config = function()
    require("date-time-inserter").setup({
      date_format = "YYYYMMDD",
      date_separator = "",
      time_format = 24,
      insert_date_map = "<leader>dt",
      insert_time_map = "<leader>tt",
      insert_date_time_map = "<leader>dtt",
    })
  end,
}
