-- lua/core/ui.lua


local fn = vim.fn

-- Diagnostic Signs
for type, icon in pairs({
  Error = " ",
  Warning = " ",
  Warn = " ",
  Hint = " ",
  Information = " ",
  Info = " ",
}) do
  local highlight = "DiagnosticSign" .. type
  fn.sign_define(highlight, { text = icon, texthl = highlight, numhl = "" })
end


-- DAP Signs
fn.sign_define("DapBreakpoint", {text = "🟠", texthl="", numhl=""})
fn.sign_define("DapBreakpointCondition", {text = "🔵", texthl="", numhl=""})
fn.sign_define("DapBreakpointRejected", { text =  "⭕", texthl="", numhl=""})
fn.sign_define("DapLogPoint",{ text = "🔶", texthl="", numhl=""})
fn.sign_define("DapStopped", { text =  "🛑", texthl="", numhl=""})


