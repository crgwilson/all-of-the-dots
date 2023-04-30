local M = {}

function M.setup()
  local null_ls_ok, null_ls = pcall(require, "null-ls")
  if not null_ls_ok then
    return
  end

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
      -- ansible
      -- diagnostics.ansiblelint,

      -- python
      diagnostics.flake8,
      diagnostics.mypy,
      formatting.black.with({ extra_args = { "--fast" } }),

      -- bash
      diagnostics.shellcheck,

      -- js / ts
      diagnostics.eslint,

      -- lua
      -- formatting.stylua,

      -- yaml
      diagnostics.yamllint,
    }
  })
end

return M
