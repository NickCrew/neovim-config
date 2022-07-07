-- vim: set foldmethod=marker foldmarker={{{,}}}
local wk = require("which-key")

-- N:SPC {{{
wk.register(
	{
		["["] = { "<cmd>BufferLineCyclePrev<cr>", "Focus Left Buffer" },
		["]"] = { "<cmd>BufferLineCycleNext<cr>", "Focus Right Buffer" },
        [","] = { "<cmd>noh<CR>", "Turn off search highlighting"},
        ["<tab>"] = {"<cmd>b#<CR>", "Last Focused Buffer"},
		a = {
			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			o = {
				"<cmd>lua vim.lsp.buf.outgoing_calls()<CR>",
				"Outgoing Calls",
			},
			a = {
				"<cmd>lua vim.lsp.buf.incoming_calls()<CR>",
				"Incoming Calls",
			},
			h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
			e = {
				"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
				"Diagnostics for Line",
			},
		},
		--
		-- Buffer
		b = {
			name = "+buffers",
			p = { "<cmd>BufferLinePick<cr>", "Pick Buffer" },
			b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
		},
		--
		-- Code
		c = {
			name = "+code",
			a = { "<cmd>CodeActionMenu<cr>", "Code Actions" },
			s = { "<cmd>AerialToggle<cr>", "Toggle Aerial" },
		},
		--
		-- Documentation
		d = {
			name = "+docs",
			d = { "<cmd>Dash<cr>", "Dash Search" },
			D = { "<cmd>Dash!<cr>", "Dash Search (No keyword)" },
			w = { "<cmd>DashWord<cr>", "Dash Search Word Under Cursor" },
			W = {
				"<cmd>DashWord!<cr>",
				"Dash Search Word Under Cursor (No keyword)",
			},
		},
		dut = {
			"<cmd>lua require'dapui'.toggle()<CR>",
			"Open DAP UI",
		},
		--
		-- Find
		f = {
			name = "+find", -- optional group name
			B = { "<cmd>Telescope file_browser<cr>", "Browse Files" },
			f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
			g = { "<cmd>Telescope live_grep<cr>", "Find String in Files" },
			o = { "<cmd>Telescope oldfiles<cr>", "Find Old File" }, -- additional options for creating the keymap
			a = { "<cmd>Telescope aerial<cr>", "Find Aerial Symbol" },
			b = {
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				"Find in Buffer",
			},
			m = { "<cmd>Telescope marks<cr>", "Find in Marks" },
			r = { "<cmd>Telescope registers<cr>", "Find in Registers" },
		},
		g = {
			name = "+git",
            c = {
              "<cmd>Gitsigns blame_line<cr>",
              "Show commit message in floating window"
            },
			b = {
				"<cmd>Gitsigns toggle_current_line_blame<cr>",
				"Toggle Blame Line",
			},
			wt = {
				"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
				"Create Git Worktree",
			},
		},
		--
		-- Current Line
		l = {
			name = "+line",
			h = {
				"<cmd>HopWordCurrentLine<CR>",
				"Hop to Word in Current Line",
			},
			l = { "<cmd>HopLine<cr>", "Hop To Line" },
		},
		--
		-- Paste
		p = {
			name = "+paste",
			p = { "<cmd>:" },
		},
		--
		-- Remaps for the refactoring operations currently offered by the plugin
		r = {
			name = "Refactoring",
			-- Extract block doesn't need visual mode
			b = {
				" <Cmd>lua require('refactoring').refactor('Extract Block')<CR>",
				"Extract Block",
			},
			bf = {
				" <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
				"Extract Block To File",
			},
			-- Inline variable can also pick up the identifier currently under the cursor without visual mode
			i = {
				" <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
				"Inline Variable",
			},
			r = {
				"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
				"Telescope Refactoring Menu",
			},
		},
		-- Search
		s = {
			name = "+search",
			g = { "<cmd>Telescope live_grep<cr>", "Search Files" },
		},
		--
		-- Diagnostics (Trouble)
		x = {
			name = "+diagnostics",
			d = {
				"<cmd>TroubleToggle document_diagnostics<cr>",
				"Document Diagnostics",
			},
			x = { "<cmd>TroubleToggle<cr>", "All Diagnostics" },
			q = {
				"<cmd>TroubleToggle quickfix<cr>",
				"Open Diagnostics in QuickFix",
			},
			r = { "<cmd>TroubleToggle lsp_references<cr>", "Show References" },
			n = {
				"<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>",
				"Next Diagnostic Item",
			},
			p = {
				"<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>",
				"Previous Diagnostic Item",
			},
		},
		--
		y = {
			name = "+yank",
			x = { "_dd", "Yank to Void Buffer" },
			y = { '"*y"', "Yank to System Clipboard" },
		},
		--
		-- Miscellaneous
	},
	-- Options
	{
		prefix = "<leader>",
	}
)
-- }}}

-- N +lsp {{{
wk.register({
  name = "+lsp",
  K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
  g = {
    D = {
      "<cmd>lua vim.lsp.buf.declaration()<CR>",
      "Go To Declaration",
    },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go To Defintion" },
    i = {
      "<cmd>lua vim.lsp.buf.implementation()<CR>",
      "Go To Implementation",
    },
    r = { 
      "<cmd>lua vim.lsp.buf.references()<CR>", "Show References" 
    },
    s = {
      "<cmd>lua vim.lsp.buf.signature_help()<CR>",
      "Signature Help",
    },
    t = {
      "<cmd>lua vim.lsp.buf.type_definition()<CR>",
      "Go To Type Definition",
    },
    W = {
      "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>",
      "Workspace Symbol",
    },
    w = {
      "<cmd>lua vim.lsp.buf.document_symbol()<CR>",
      "Document Symbol",
    },
    ["]"] = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
      "Go To Previous",
    },
    ["["] = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Go To Next",
    },
  },
}, {
  mode = "n",
})
-- }}}

-- N:g +lsp {{{
wk.register({
  name = "+lsp",
  p = {
    c = {
      "<cmd>lua require('goto-preview').close_all_win()<CR>",
      "Close All Preview Windows",
    },
    d = {
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      "Preview Definition",
    },
    i = {
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      "Preview Implementation",
    },
    r = {
      "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
      "Preview References",
    },
  },
}, { prefix = "g", mode = "n" })
-- }}}

-- F-Keys +dap {{{
wk.register({

  ["<F3>"] = { "<cmd>DapVirtualTextForceRefresh<cr>", "Refresh Virtual Text" },
  ["<F4>"] = { "<cmd>lua require('dap').run_last()<cr>", "Run Last" },
  ["<F5>"] = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
  ["<F6>"] = { "<cmd>lua require('dap').run_to_cursor()<cr>", "Run To Cursor" },
  ["<F7>"] = { "<cmd>lua require('dap').pause()<cr>", "Pause" },
  ["<F8>"] = {
    "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
    "Conditional Breakpoint",
  },
  ["<F9>"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  ["<F10>"] = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
  ["<F11>"] = { "<cmd>lua require('dap').step_into()<cr>", "Step In" },
  ["<F12>"] = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
})
-- }}}

-- SPC+SPC +dap {{{ 
wk.register({
  name = "+dap",
  r = { "<cmd>lua require('dap').repl.toggle()<CR>", "Toggle REPL" },
  e = { "<cmd>lua require('dap').eval()<cr>", "Evaluate" },
  h = {
    "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
    "Harpoon Quick Menu",
  },
}, {
  prefix = "<leader><leader>",
})
-- }}}

-- CTRL+A +nav {{{
wk.register({
  name = "+nav",
  a = { "<cmd>AerialToggle<cr>", "Toggle Aerial" },
  f = { "<cmd>Fern . -drawer -toggle<cr>", "Toggle File Tree" },
  ["<C-h>"] = { "<cmd>lua require('spectre').open()<cr>", "Find and Replace" },
  h = {
    "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
    "Harpoon Quick Menu",
  },
  m = { "<cmd>Telescope harpoon marks<cr>", "Find Harpoon Marks (Telescope)" },
  A = {
    "<cmd>lua require('harpoon.mark').add_file()<cr>",
    "Add Harpoon Mark",
  },
  ["<C-j>"] = {
    "<cmd>lua require('harpoon.ui').nav_next()<cr>",
    "Next Harpoon Mark",
  },
  ["<C-k>"] = {
    "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
    "Previous Harpoon Mark",
  },

  ["1"] = {
    "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
    "Harpoon Mark 1",
  },
  ["2"] = {
    "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
    "Harpoon Mark 2",
  },
  ["3"] = {
    "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
    "Harpoon Mark 3",
  },
  ["4"] = {
    "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
    "Harpoon Mark 4",
  },
  ["5"] = {
    "<cmd>lua require('harpoon.ui').nav_file(5)<cr>",
    "Harpoon Mark 4",
  },
}, {
  prefix = "<C-a>",
})
-- }}}

-- CTRL+K +telescope {{{
wk.register({
  name = "+telescope",
  a = { "<cmd>Telescope aerial<cr>", "Find Aerial Symbol"},
  b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
  d = { "<cmd>Telescope dap commands<cr>", "Find DAP Command" },
  l = { "<cmd>Telescope luasnip<cr>", "Find Snippet"},
  c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
  r = { "<cmd>Telescope refactoring<cr>", "Refactoring"},
  m = { "<cmd>Telescope marks", "Marks"}

}, {
  prefix = "<C-k>"
})

-- }}}

-- V:SPC +refactor {{{
wk.register({
	name = "+refactor",
	e = {
		" <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
		"Extract Function",
	},
	f = {
		" <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
		"Extract Function To File",
	},
	v = {
		" <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
		"Extract Variable",
	},
	i = {
		" <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
		"Inline Variable",
	},
}, {
	prefix = "<leader>",
	mode = "v",
})
-- }}}

-- SPC +lsp {{{
wk.register({
  name = "+lsp",
  l = {
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    o = {
      "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>",
      "Outgoing Calls",
    },
    i = {
      "<cmd>lua vim.lsp.buf.incoming_calls()<CR>",
      "Incoming Calls",
    },
    a = { "<cmd>lua vim.diagnostic.open_float()<CR>", "View Diagnostic" },
  },
}, {
  prefix = "<leader>",
})
-- }}}

-- MISC {{{
wk.register({
  ["<C-e><C-r>"] = { "<cmd>LspRestart<cr>", "Restart LSP" },
})
-- }}}
