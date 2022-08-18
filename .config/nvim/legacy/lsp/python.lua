-- npm i -g pyright
local lspconfig = require("lspconfig")
local u = require("utils")


local M = {}
M.setup = function(on_attach)
    lspconfig.pyright.setup({
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            on_attach(client, bufnr)

            vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        end,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

return M
