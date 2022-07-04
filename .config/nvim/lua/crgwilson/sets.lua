vim.cmd("syntax on")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2  -- remove <Tab> characters
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 1

vim.opt.lazyredraw = true
vim.opt.mouse = ""

vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true

vim.opt.splitbelow = true
vim.opt.splitright = true

-- create undo directory if doesnt exist
local undodir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.empty(vim.fn.glob(undodir)) > 0 then
  vim.fn.mkdir(undodir)
end
vim.opt.undodir = undodir
vim.opt.undofile = true
vim.opt.undoreload = 10000

-- no backups
vim.opt.backup = false
vim.opt.writebackup = false

local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd(
  "TextYankPost", {
    pattern = "*",
    command = 'silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}',
    group = highlight_yank
  }
)
