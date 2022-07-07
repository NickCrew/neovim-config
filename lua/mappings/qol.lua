--
-- Quality of Life Mappings
--

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Quick center screen
map("n", "<C-;>", "zz", opts)

-- Center screen after jumping to search results
map("n", "N", "Nzz", opts)
map("n", "n", "nzz", opts)

-- Quicker window switching
map("n", "<C-h>", "<C-w><C-h>", opts)
map("n", "<C-j>", "<C-w><C-j>", opts)
map("n", "<C-k>", "<C-w><C-k>", opts)
map("n", "<C-l>", "<C-w><C-l>", opts)

-- Switch windows and maximize
map("n", "<M-left>", "<C-w>h<C-w>|", opts)
map("n", "<M-right>", "<C-w>l<C-w>|", opts)
map("n", "<M-down>", "<C-w>j<C-w>_", opts)
map("n", "<M-up>", "<C-w>k<C-w>_", opts)

-- kill it with fire
map("n", "q:", "<nop>", opts)
map("n", "Q", "<nop>", opts)



