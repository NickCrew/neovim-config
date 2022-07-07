-- Global Variables

local g = vim.g
local user_settings = require("user.settings")

-- Map leader
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

-- Global Variables
g.python3_host_prog = user_settings.python_path

-- Plugin Global Variables
g.cursorhold_updatetime = 100 -- plugin: fix-cursorhold

function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], { noremap = true })
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], { noremap = true })
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], { noremap = true })
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], { noremap = true })
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], { noremap = true })
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], { noremap = true })
end

