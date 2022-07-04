local fn = vim.fn
local installer = {}

function installer.installFromGit(repo, path)
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

return installer
