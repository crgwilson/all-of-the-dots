local fn = vim.fn
local M = {}

function M.install_from_git(repo, path)
  fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    repo,
    path,
  })
  vim.notify(
    "Installing git repository " .. repo,
    3
  )
end

return M
