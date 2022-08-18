local black = {
    formatCommand = "black --fast -",
    formatStdin = true,
}
local isort = {
    formatCommand = "isort --stdout --profile black -",
    formatStdin = true,
}
local flake8 = {
    lintCommand = "flake8 --max-line-length 120 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
    lintSource = "flake8",
}
local mypy = {
    lintCommand = "mypy --show-column-numbers --ignore-missing-imports --show-error-codes",
    lintFormats = {
        "%f:%l:%c: %trror: %m",
        "%f:%l:%c: %tarning: %m",
        "%f:%l:%c: %tote: %m",
    },
    lintSource = "mypy",
}
local eslint = {
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {
        "%f(%l,%c): %tarning %m",
        "%f(%l,%c): %rror %m",
    },
    lintSource = "eslint",
}
local prettier = {
    formatCommand = [[$([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "npx prettier") --stdin-filepath ${INPUT} ${--config-precedence:configPrecedence} ${--tab-width:tabWidth} ${--single-quote:singleQuote} ${--trailing-comma:trailingComma}]],
    formatStdin = true,
}

return {
    filetypes = { "python", "javascript" },
    root_dir = function() return vim.fn.getcwd() end;
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            python = { black, isort, flake8 },
            typescript = { prettier, eslint },
            javascript = { prettier, eslint },
            typescriptreact = { prettier, eslint },
            javascriptreact = { prettier, eslint },
            yaml = { prettier },
            json = { prettier },
            html = { prettier },
            scss = { prettier },
            css = { prettier },
            markdown = { prettier },
        },
    },
}
