local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

return h.make_builtin({
    name = "black",
    meta = {
        url = "https://github.com/PyCQA/autoflake",
        description = "autoflake removes unused imports and unused variables from Python code",
    },
    method = FORMATTING,
    filetypes = { "python" },
    generator_opts = {
        command = "autoflake",
        args = {
            "--remove-all-unused-imports",
            "--stdout",
            "$FILENAME",
        },
        to_stdin = true,
    },
    factory = h.formatter_factory,
})
