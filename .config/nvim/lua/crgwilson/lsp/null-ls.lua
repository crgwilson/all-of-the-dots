local M = {}

function M.setup()
    local null_ls_ok, null_ls = pcall(require, "null-ls")
    local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
    if not null_ls_ok or not mason_null_ls_ok then
        return
    end

    mason_null_ls.setup({
        ensure_installed = {
            "stylua",
            "golangci-lint",
            "prettier",
        },
    })

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
        debug = false,

        root_dir = require("null-ls.utils").root_pattern(
            ".null-ls-root",
            "setup.cfg",
            "package.json",
            "Makefile",
            ".git"
        ),

        sources = {
            -- python
            -- Ignored errors are already caught by pyright
            diagnostics.flake8.with({ extra_args = { "--ignore=Q000,F401,F841,W503" }}),
            formatting.black.with({ extra_args = { "--fast" } }),

            -- golang
            -- diagnostics.golangci_lint,

            -- js / ts
            -- diagnostics.eslint,
            formatting.prettier,

            -- java
            -- diagnostics.checkstyle,

            -- lua
            formatting.stylua,

            -- yaml
            diagnostics.yamllint,
        },
    })
end

return M
