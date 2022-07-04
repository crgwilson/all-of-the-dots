-- local pluginUtils = require("crgwilson.utils.plugins")
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "

local options = {
  noremap = true,
  silent = true,
}

-- -- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- integrated terminal
keymap("t", "<Esc>", [[<C-\><C-n>]], options)

-- start terminal in insert mode
vim.api.nvim_create_autocmd(
  "BufEnter", {
    pattern = "*",
    command = "if &buftype == 'terminal' | :startinsert | endif"
  }
)
function open_terminal()
  vim.cmd("split term://zsh")
  vim.cmd("resize 10")
end
keymap("n", "<C-n>", ":lua open_terminal()<CR>", options)

-- navigate between splits with ctrl+movement keys
keymap("n", "<C-j>", "<C-W>j", options)
keymap("n", "<C-k>", "<C-W>k", options)
keymap("n", "<C-h>", "<C-W>h", options)
keymap("n", "<C-l>", "<C-W>l", options)

-- cycle through buffers
keymap("n", "<S-l>", ":bnext<cr>", options)
keymap("n", "<S-h>", ":bprevious<cr>", options)

-- cycle through tabs
keymap("n", "<Left>", ":tabprevious<cr>", options)
keymap("n", "<Right>", ":tabnext<cr>", options)
keymap("n", "<leader>1", "1gt", options)
keymap("n", "<leader>2", "2gt", options)
keymap("n", "<leader>3", "3gt", options)
keymap("n", "<leader>4", "4gt", options)

-- stay in indent mode
keymap("v", "<", "<gv", options)
keymap("v", ">", ">gv", options)

-- easy way to save
keymap("n", "<C-s>", ":w<CR>", options)

-- telescope.nvim
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", options)
keymap("n", "<leader>fo", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", options)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", options)
keymap("n", "<leader>fG", "<cmd>lua require('telescope.builtin').git_commits()<cr>", options)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').git_branches()<cr>", options)
keymap("n", "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<cr>", options)
keymap("n", "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", options)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", options)
-- TODO: Snippets, code actions, renames

-- nvim-tree
keymap("n", "<F1>", ":NvimTreeToggle<cr>", options)
