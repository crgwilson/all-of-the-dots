vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false

vim.opt.list = true
vim.opt.listchars:append "eol:↴"

vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2  -- remove <Tab> characters
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

vim.opt.foldmethod = "indent"
vim.opt.foldenable = true
vim.opt.foldlevel = 99

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

-- Plugin specific sets
--
-- ansible-vim
vim.g.ansible_unindent_after_newline = 1
vim.g.ansible_attribute_highlight = "ob"

-- vim-go
vim.g.go_code_completion_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_fmt_autosave = 0

-- vim-illuminate
vim.g.Illuminate_ftblacklist = { [[nerdtree]], [[md]] }

-- Augroups & Autocmds
local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd(
  "TextYankPost", {
    pattern = "*",
    command = 'silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}',
    group = highlight_yank
  }
)

local illuminate_augroup = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true })
vim.api.nvim_create_autocmd(
  "VimEnter", {
    pattern = "*",
    command = "hi illuminatedWord cterm=bold,underline gui=bold,underline",
    group = illuminate_augroup
  }
)

-- For whatever reason whenever I trigger an lsp / cmp pop up (autocomplete, buf.hover(), etc)
-- better whitespace gets confused and starts highlighting whitespace even in insert mode.
local better_whitespace_and_lsp = vim.api.nvim_create_augroup("better_whitespace_and_lsp", { clear = true })
vim.api.nvim_create_autocmd(
  "InsertEnter", {
    pattern = "*",
    command = "if exists(':EnableWhitespace') | execute 'EnableWhitespace' | endif",
    group = better_whitespace_and_lsp,
  }
)
vim.api.nvim_create_autocmd(
  "InsertLeave", {
    pattern = "*",
    command = "if exists(':DisableWhitespace') | execute 'DisableWhitespace' | endif",
    group = better_whitespace_and_lsp,
  }
)
