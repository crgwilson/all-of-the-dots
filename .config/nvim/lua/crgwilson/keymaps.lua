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
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "if &buftype == 'terminal' | :startinsert | endif",
})
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
keymap("n", "<C-s>", ":w<cr>", options)

-- quickfix list
keymap("n", "<leader>q", ":copen<cr>", options)
keymap("n", "<leader>Q", ":cclose<cr>", options)

-- telescope.nvim
keymap(
    "n",
    "<leader>ff",
    "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>",
    options
)
keymap(
    "n",
    "<leader>fF",
    "<cmd>lua require('telescope.builtin').git_files()<cr>",
    options
)
keymap(
    "n",
    "<leader>fo",
    "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
    options
)
keymap(
    "n",
    "<leader>fg",
    "<cmd>lua require('telescope.builtin').live_grep()<cr>",
    options
)
keymap(
    "n",
    "<leader>fG",
    "<cmd>lua require('telescope.builtin').git_commits()<cr>",
    options
)
keymap(
    "n",
    "<leader>fb",
    "<cmd>lua require('telescope.builtin').git_branches()<cr>",
    options
)
keymap(
    "n",
    "<leader>fc",
    "<cmd>lua require('telescope.builtin').commands()<cr>",
    options
)
keymap(
    "n",
    "<leader>fk",
    "<cmd>lua require('telescope.builtin').keymaps()<cr>",
    options
)
keymap(
    "n",
    "<leader>fh",
    "<cmd>lua require('telescope.builtin').help_tags()<cr>",
    options
)

-- nvim-tree
keymap("n", "<F1>", ":NvimTreeToggle<cr>", options)
keymap("n", "<leader>t", ":NvimTreeToggle<cr>", options)

-- Mason
keymap("n", "<leader>M", ":Mason<cr>", options)

-- lsp
keymap("n", "<leader>lr", ":LspRestart<cr>", options)
keymap("n", "<leader>li", ":LspInfo<cr>", options)

-- dap
keymap(
    "n",
    "<leader>B",
    "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
    options
)
keymap("n", "<leader>bc", "<cmd>lua require'dap'.continue()<cr>", options)
keymap("n", "<leader>bs", "<cmd>lua require'dap'.step_over()<cr>", options)
keymap("n", "<leader>bS", "<cmd>lua require'dap'.step_into()<cr>", options)
keymap("n", "<leader>bo", "<cmd>lua require'dap'.step_out()<cr>", options)
keymap("n", "<leader>br", "<cmd>lua require'dap'.repl.open()<cr>", options)
keymap("n", "<leader>bT", "<cmd>lua require'dap'.terminate()<cr>", options)
keymap("n", "<leader>bu", "<cmd>lua require'dapui'.toggle()<cr>", options)

-- fugitive
keymap("n", "<leader>gb", "<cmd>Git blame<cr>", options)
keymap("n", "<leader>ga", "<cmd>Git a<cr>", options)
keymap("n", "<leader>gr", "<cmd>Git reset<cr>", options)
keymap("n", "<leader>gc", "<cmd>Git commit<cr>", options)
keymap("n", "<leader>gs", "<cmd>Git status<cr>", options)
keymap("n", "<leader>gd", "<cmd>Git difftool<cr>", options)
keymap("n", "<leader>gD", "<cmd>Gdiffsplit<cr>", options)
