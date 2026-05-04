return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  lazy = false,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local function require_textobjects_module(name)
      local ok, module = pcall(require, "nvim-treesitter-textobjects." .. name)
      if ok then
        return module
      end

      ok, module = pcall(require, "nvim-treesitter.textobjects." .. name)
      if ok then
        return module
      end
    end

    local ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
    if ok and type(textobjects.setup) == "function" then
      textobjects.setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })
    end

    local function select_textobject(query, group)
      return function()
        local select = require_textobjects_module("select")
        if select then
          select.select_textobject(query, group or "textobjects")
        end
      end
    end

    local function swap_textobject(method, query, group)
      return function()
        local swap = require_textobjects_module("swap")
        if swap then
          swap[method](query, group or "textobjects")
        end
      end
    end

    local function move_to_textobject(method, query, group)
      return function()
        local move = require_textobjects_module("move")
        if move then
          move[method](query, group or "textobjects")
        end
      end
    end

    local select_keymaps = {
      ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
      ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
      ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
      ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

      ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
      ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
      ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
      ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

      ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
      ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

      ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
      ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

      ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
      ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

      ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
      ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

      ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
      ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

      ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
      ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
    }

    for lhs, mapping in pairs(select_keymaps) do
      vim.keymap.set({ "x", "o" }, lhs, select_textobject(mapping.query), { desc = mapping.desc })
    end

    vim.keymap.set("n", "<leader>na", swap_textobject("swap_next", "@parameter.inner"), {
      desc = "Swap parameter/argument with next",
    })
    vim.keymap.set("n", "<leader>n:", swap_textobject("swap_next", "@property.outer"), {
      desc = "Swap object property with next",
    })
    vim.keymap.set("n", "<leader>nm", swap_textobject("swap_next", "@function.outer"), {
      desc = "Swap function with next",
    })
    vim.keymap.set("n", "<leader>pa", swap_textobject("swap_previous", "@parameter.inner"), {
      desc = "Swap parameter/argument with previous",
    })
    vim.keymap.set("n", "<leader>p:", swap_textobject("swap_previous", "@property.outer"), {
      desc = "Swap object property with previous",
    })
    vim.keymap.set("n", "<leader>pm", swap_textobject("swap_previous", "@function.outer"), {
      desc = "Swap function with previous",
    })

    local move_keymaps = {
      ["]f"] = { method = "goto_next_start", query = "@call.outer", desc = "Next function call start" },
      ["]m"] = { method = "goto_next_start", query = "@function.outer", desc = "Next method/function def start" },
      ["]c"] = { method = "goto_next_start", query = "@class.outer", desc = "Next class start" },
      ["]i"] = { method = "goto_next_start", query = "@conditional.outer", desc = "Next conditional start" },
      ["]l"] = { method = "goto_next_start", query = "@loop.outer", desc = "Next loop start" },
      ["]s"] = { method = "goto_next_start", query = "@local.scope", group = "locals", desc = "Next scope" },
      ["]z"] = { method = "goto_next_start", query = "@fold", group = "folds", desc = "Next fold" },

      ["]F"] = { method = "goto_next_end", query = "@call.outer", desc = "Next function call end" },
      ["]M"] = { method = "goto_next_end", query = "@function.outer", desc = "Next method/function def end" },
      ["]C"] = { method = "goto_next_end", query = "@class.outer", desc = "Next class end" },
      ["]I"] = { method = "goto_next_end", query = "@conditional.outer", desc = "Next conditional end" },
      ["]L"] = { method = "goto_next_end", query = "@loop.outer", desc = "Next loop end" },

      ["[f"] = { method = "goto_previous_start", query = "@call.outer", desc = "Prev function call start" },
      ["[m"] = { method = "goto_previous_start", query = "@function.outer", desc = "Prev method/function def start" },
      ["[c"] = { method = "goto_previous_start", query = "@class.outer", desc = "Prev class start" },
      ["[i"] = { method = "goto_previous_start", query = "@conditional.outer", desc = "Prev conditional start" },
      ["[l"] = { method = "goto_previous_start", query = "@loop.outer", desc = "Prev loop start" },

      ["[F"] = { method = "goto_previous_end", query = "@call.outer", desc = "Prev function call end" },
      ["[M"] = { method = "goto_previous_end", query = "@function.outer", desc = "Prev method/function def end" },
      ["[C"] = { method = "goto_previous_end", query = "@class.outer", desc = "Prev class end" },
      ["[I"] = { method = "goto_previous_end", query = "@conditional.outer", desc = "Prev conditional end" },
      ["[L"] = { method = "goto_previous_end", query = "@loop.outer", desc = "Prev loop end" },
    }

    for lhs, mapping in pairs(move_keymaps) do
      vim.keymap.set({ "n", "x", "o" }, lhs, move_to_textobject(mapping.method, mapping.query, mapping.group), {
        desc = mapping.desc,
      })
    end

    local repeatable_move = require_textobjects_module("repeatable_move")
    if repeatable_move then
      vim.keymap.set({ "n", "x", "o" }, ";", repeatable_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", repeatable_move.repeat_last_move_opposite)

      vim.keymap.set({ "n", "x", "o" }, "f", repeatable_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", repeatable_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", repeatable_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", repeatable_move.builtin_T_expr, { expr = true })
    end
  end,
}
