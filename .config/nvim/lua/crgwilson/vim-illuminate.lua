local g = vim.g

g.Illuminate_ftblacklist = { [[nerdtree]], [[md]] }

local illuminate_augroup = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true })
vim.api.nvim_create_autocmd(
  "VimEnter", {
    pattern = "*",
    command = "hi illuminatedWord cterm=bold,underline gui=bold,underline",
    group = illuminate_augroup
  }
)
