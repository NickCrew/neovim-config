local vim = vim
local user_settings = require('user.settings')

local M = {}

function M.toggle_qf()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end

function M.resize_split(plus_or_minus)
  local vim = vim
  -- full height window height is screen height minus 3 for bufferline, status line, and command line
  local is_vert_split = vim.fn.winheight(vim.fn.winnr()) + 3 == vim.o.lines
  if is_vert_split then
    if plus_or_minus == "plus" then
      vim.cmd("vertical resize +3")
    else
      vim.cmd("vertical resize -3")
    end
  else
    if plus_or_minus == "plus" then
      vim.cmd("resize +3")
    else
      vim.cmd("resize -3")
    end
  end
end

function M.disable_builtins()
  local disabled_built_ins = user_settings.disabled_builtin_plugins
  for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
  end
end

function M.listen_for_lights()
  local pid = string(vim.fn.getpid())
  local socket_name = '/tmp/nvim/nvim' .. pid .. '.sock'
  vim.fn.mkdir('/tmp/nvim', 'p')
  vim.fn.call.serverstart(socket_name)
end

function M.update_theme()
  local is_dark = vim._system('isdark')
  require('config.nightfox')

  if is_dark then
    vim.opt.background = 'dark'
    vim.cmd("colorscheme catppuccin")
  else
    vim.opt.background = 'light'
    vim.cmd("colorscheme dawnfox")
  end


end


return M
