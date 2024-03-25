vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4 -- remove <Tab> characters
vim.opt.shiftwidth = 4
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

vim.opt.undofile = false

-- no backups
vim.opt.backup = false
vim.opt.writebackup = false

-- Plugin specific sets
--
-- ansible-vim
vim.g.ansible_unindent_after_newline = 1

-- vim-go
vim.g.go_code_completion_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_fmt_autosave = 0

-- vim-illuminate
vim.g.Illuminate_ftblacklist = { [[nerdtree]], [[md]] }

-- Augroups & Autocmds
local highlight_yank =
    vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    command = "silent! lua vim.highlight.on_yank{higroup=\"IncSearch\", timeout=700}",
    group = highlight_yank,
})

local illuminate_augroup =
    vim.api.nvim_create_augroup("illuminate_augroup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    command = "hi illuminatedWord cterm=bold,underline gui=bold,underline",
    group = illuminate_augroup,
})

-- Let's just try getting rid of better whitespace for a while
vim.g.better_whitespace_enabled = 0
