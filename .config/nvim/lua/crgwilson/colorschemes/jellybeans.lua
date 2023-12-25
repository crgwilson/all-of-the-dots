local M = {}

function M.setup()
    vim.cmd([[
    let g:jellybeans_overrides = {'background': { 'ctermbg': 'none', '256ctermbg': 'none', 'guibg': 'none'}}
  ]])
end

return M
