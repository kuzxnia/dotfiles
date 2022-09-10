local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local autoflake = require("user.lsp.settings.autoflake")

null_ls.setup({
	debug = true,
	sources = {
    diagnostics.flake8,
    autoflake,
		formatting.isort,
		formatting.black.with({ extra_args = { "--fast", "-l 120" } }), -- should be at the end of python formatters

		-- formatting.prettierd.with({filetypes = { "html", "json", "yaml", } }),
		formatting.prettier,
		code_actions.gitsigns,
	},
})
