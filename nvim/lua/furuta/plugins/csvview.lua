return {
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      view = { display_mode = "border" },
      parser = { comments = { "#", "//" } },
      keymaps = {
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end = { "L", mode = { "n", "v" } },
        jump_prev_field_end = { "H", mode = { "n", "v" } },
        jump_next_row = { "J", mode = { "n", "v" } },
        jump_prev_row = { "K", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
}
