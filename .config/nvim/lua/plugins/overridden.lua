return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["<S-CR>"] = "system_open",
          ["<Space>"] = false,
          ["[b"] = "prev_source",
          ["]b"] = "next_source",
          O = "system_open",
          Y = "copy_selector",
          h = "parent_or_close",
          l = "child_or_open",
          ["o"] = "open",
          ["oc"] = false,
          ["od"] = false,
          ["og"] = false,
          ["om"] = false,
          ["on"] = false,
          ["os"] = false,
          ["ot"] = false,
        },
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",

    config = function()
      require("refactoring").setup {
        -- prompt for return type
        prompt_func_return_type = {
          go = true,
          java = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
          go = true,
          java = true,
        },
      }
    end,
  },
}
