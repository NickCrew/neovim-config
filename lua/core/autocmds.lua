-- lua/core/cmds/auto.lua
--
-- Auto-Commands
-------------------------------------------------------------

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- AutoCommand Groups
augroup("packer_user_config", {})
augroup("hover", {})
augroup("windows", {})
augroup("terms", {})


autocmd("BufWritePost", {
  desc = "Auto Compile plugins.lua file",
  group = "packer_user_config",
  command = "source <afile> | PackerCompile",
  pattern = "plugins.lua",
})

autocmd("CursorHold", {
  group = "hover",
  pattern = "*",
  command = "lua require('nvim-lightbulb').update_lightbulb()",
})

autocmd("CursorHoldI", {
  group = "hover",
  pattern = "*",
  command = "lua require('nvim-lightbulb').update_lightbulb()",
})

autocmd("CursorHold", {
  group = "hover",
  pattern = "*",
  command = 'lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor", border="rounded"})',
})

autocmd("termopen", {
  group = "terms",
  pattern = "term://*",
  command = "lua set_terminal_keymaps()",
})
