-- lua/core/cmds/user.lua
--
-- User-Defined Commands
-------------------------------------------------------------

local usercmd = vim.api.nvim_create_user_command

-- User Commands
usercmd("TestFunc", "lua require('dap-python').test_method()", {})
usercmd("TestClass", "lua require('dap-python').test_class()", {})
usercmd("DebugSelection", "lua require('dap-python').debug_selection()", {})
usercmd("BreakpointToggle", "lua require('dap').toggle_breakpoint()", {})
usercmd("Debug", "lua require('dap').continue()", {})
usercmd("DapREPL", "lua require('dap').repl.open()", {})
usercmd("UpdateTheme", "lua require('core.utils').update_theme()", {})
usercmd("Fmt", "lua vim.lsp.buf.format({async = true})", {})
usercmd("Halp", "help halp<cr>", {})

-- Abbreviations
vim.cmd([[
  cnoreabbrev F Fern
  cnoreabbrev T Telescope
  cnoreabbrev L Legendary
  cnoreabbrev N Neogen
  cnoreabbrev PC PackerCompile
  cnoreabbrev PI PackerInstall
  cnoreabbrev G Gitsigns
]])

