-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.mypy,
    }
    return config -- return final config table
  end,
}

-- local null_ls = require "null-ls"
-- local helpers = require "null-ls.helpers"
-- local overrides = {
--   severities = {
--     error = helpers.diagnostics.severities["error"],
--     warning = helpers.diagnostics.severities["warning"],
--     note = helpers.diagnostics.severities["information"],
--   },
-- }
--
-- local flake8 = {
--   method = null_ls.methods.DIAGNOSTICS,
--   filetypes = { "python" },
--   name = "flake8",
--   -- null_ls.generator creates an async source
--   -- that spawns the command with the given arguments and options
--   generator = null_ls.generator {
--     command = "flake8",
--     args = { "--max-line-length=120" },
--     to_temp_file = true,
--     format = "line",
--     check_exit_code = function(code) return code <= 2 end,
--     multiple_files = true,
--     on_output = helpers.diagnostics.from_patterns {
--       -- see spec for pattern examples
--       {
--         pattern = "([^:]+):(%d+):(%d+): (%a+): (.*)  %[([%a-]+)%]",
--         groups = { "filename", "row", "col", "severity", "message", "code" },
--         overrides = overrides,
--       },
--       -- no error code
--       {
--         pattern = "([^:]+):(%d+):(%d+): (%a+): (.*)",
--         groups = { "filename", "row", "col", "severity", "message" },
--         overrides = overrides,
--       },
--       -- no column or error code
--       {
--         pattern = "([^:]+):(%d+): (%a+): (.*)",
--         groups = { "filename", "row", "severity", "message" },
--         overrides = overrides,
--       },
--     },
--   },
-- }
-- null_ls.register(flake8)
