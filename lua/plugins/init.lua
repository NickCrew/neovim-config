-- lua/plugins.lua
--

local vim = vim
local fn = vim.fn

-- Automatically install Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/'wbthomason/packer.nvim",
		install_path,
	})
end

-- Use a protected call so we don't error out on first use.
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	max_jobs = 10
})

return packer.startup({
	function(use)
		-- Packer itself
		use({ "wbthomason/packer.nvim" })

		use({ "famiu/nvim-reload" })

		use({ "andymass/vim-matchup" })

		use({ "chaoren/vim-wordmotion" })

		use({ "matze/vim-move" })

		use({ "antoinemadec/FixCursorHold.nvim" })

		use({ "kyazdani42/nvim-web-devicons" })

		use({ "tpope/vim-commentary" })

		use({ "andrewradev/switch.vim" })

		use({ "simnalamburt/vim-mundo" })

		use({ "b0o/schemastore.nvim" })

		use({ "ellisonleao/glow.nvim" })  -- markdown preview

		use({ "RishabhRD/popfix" })

		use({  -- clipboard history
			"AckslD/nvim-neoclip.lua",
			requires = {
				{ "tami5/sqlite.lua", module = "sqlite" },
				{ "nvim-telescope/telescope.nvim" },
			},
			config = function()
				require("neoclip").setup({
					history = 1000,
					enable_persistent_history = true,
					continuous_sync = false,
				})
                require('telescope').load_extension('neoclip')
			end,
		})

		use({ "EthanJWright/vs-tasks.nvim" })  -- launch.json support

		use({  -- LSP Symbol Drawer
			"stevearc/aerial.nvim",
			after = "telescope.nvim",
			config = function()
				require("aerial").setup({
					backends = { "lsp", "treesitter", "markdown" },
					close_behavior = "auto",
					default_direction = "prefer_right",
					min_width = 30,
					max_width = 50,
					post_jump_cmd = "normal! zz",
					lsp = {
						diagnostics_trigger_update = true,
						update_when_errors = true,
					},
					treesitter = {
						update_delay = 300,
					},
					markdown = {
						update_delay = 300,
					},
				})
				require("telescope").load_extension("aerial")
			end,
		})


		use({  -- Quick movements
			"phaazon/hop.nvim",
			config = function()
				require("hop").setup({
					case_insensitive = true,
					char2_fallback_key = "<CR>",
				})
			end,
		})

        use({  -- Sneak/quick movements
          "ggandor/leap.nvim",
          requires = "tpope/vim-repeat",
          config = function()
            require('leap').set_default_keymaps()
          end
        })

		use({
			"ThePrimeagen/harpoon",
			before = "telescope.nvim",
			config = function()
				require("config.harpoon")
			end,
		})

		use({
			"lazytanuki/nvim-mapper",
			config = function()
				require("nvim-mapper").setup({
					no_map = false,
					search_path = os.getenv("HOME") .. "/.config/nvim/lua",
					action_on_enter = "definition",
				})
			end,
			before = "telescope.nvim",
		})


		use({  -- RESTful API and HTTP Client
			"NTBBloodbath/rest.nvim",
			config = function()
				require("config.rest-nvim")
			end,
		})


		use({  -- Powerful find and replace
			"windwp/nvim-spectre",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("spectre").setup()
			end,
		})


		use({  -- Smart delimiters and pairs
			"windwp/nvim-autopairs",
			config = function()
				require("config.autopairs")
			end,
		})

		use({  -- Popup preview window for LSP
			"rmagatti/goto-preview",
			event = "BufEnter",
			config = function()
				require("config.gotopreview")
			end,
		})


		use({  -- Project Drawer
			"lambdalisue/fern.vim",
			requires = {
				"yuki-yano/fern-preview.vim",
				"lambdalisue/fern-hijack.vim",
				"lambdalisue/fern-mapping-quickfix.vim",
				"lambdalisue/nerdfont.vim",
				"lambdalisue/fern-renderer-nerdfont.vim",
				"lambdalisue/fern-git-status.vim",
				"lambdalisue/fern-bookmark.vim",
			},
		})


		use({  -- Better quickfix window
			"kevinhwang91/nvim-bqf",
			ft = "qf",
			config = function()
				require("bqf").setup()
			end,
		})

		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("config.null-ls")
			end,
		})

		use({
			"neovim/nvim-lspconfig",
			event = "BufEnter",
			requires = {
				"ray-x/lsp_signature.nvim",
				"williamboman/nvim-lsp-installer",
				"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
				"jose-elias-alvarez/nvim-lsp-ts-utils",
				"folke/lsp-colors.nvim",
				"nvim-lua/lsp-status.nvim",
				"kosayoda/nvim-lightbulb",
				"simrat39/rust-tools.nvim",
				{ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
			},
			config = function()
				require("lsp")
			end,
		})

		use({  -- Dim parts of your code you're not workingon
			"folke/twilight.nvim",
			config = function()
				require("twilight").setup({})
			end,
		})


		use({  -- Show status of language server loading in buffer
		"j-hui/fidget.nvim",
		event = "BufEnter",
		config = function()
		require("fidget").setup({
		          sources = {
		            code_action = {
		              ignore = true
		            }
		          }
		        })
		end,
		})


		use({  -- Smart Session Management
			"folke/persistence.nvim",
			event = "BufReadPre", -- this will only start session saving when an actual file was opened
			module = "persistence",
			config = function()
				require("persistence").setup()
			end,
		})

		use({  -- Syntax highlighting and parsiging
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"p00f/nvim-ts-rainbow",
				"romgrk/nvim-treesitter-context",
				"nvim-treesitter/playground",
				"RRethy/nvim-treesitter-textsubjects",
				"nvim-treesitter/nvim-treesitter-textobjects",
				{
					"nvim-treesitter/playground",
					cmd = {
						"TSPlaygroundToggle",
						"TSHighlightCapturesUnderCursor",
					},
				},
			},
			run = ":TSUpdate",
			config = function()
				require("config.treesitter")
			end,
		})


		use({  -- Docstring generator
			"danymat/neogen",
			config = function()
				require("neogen").setup({
					enabled = true,
					languages = {
						python = {
							template = {
								annotation_convention = "google_docstrings",
							},
						},
					},
				})
			end,
		})

		use({
			"ThePrimeagen/refactoring.nvim",
			config = function()
				require("refactoring").setup()
			end,
		})


		use({  -- treesitter based colorizing
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"html",
				})
			end,
		})


		use({  -- Enhance LSP Diagnostics
			"folke/trouble.nvim",
			before = "telescope.nvim",
			config = function()
				require("trouble").setup({

				})
			end,
		})

		use({
			"junegunn/fzf",
			run = function()
				vim.fn["fzf#install"]()
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-lua/popup.nvim",
				"tami5/sqlite.lua",
				"LinArcX/telescope-env.nvim",
				"nvim-telescope/telescope-file-browser.nvim",
				"nvim-telescope/telescope-media-files.nvim",
				"nvim-telescope/telescope-frecency.nvim",
				"jvgrootveld/telescope-zoxide",
				"nvim-telescope/telescope-github.nvim",
				"nvim-telescope/telescope-live-grep-raw.nvim",
				"nvim-telescope/telescope-symbols.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
				"nvim-telescope/telescope-node-modules.nvim",
				{
					"nvim-telescope/telescope-dap.nvim",
					requires = "mfussenegger/nvim-dap",
				},
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				{ "mrjones2014/dash.nvim", run = "make install" },
			},
			config = function()
				require("config.telescope")
			end,
		})

		use({ "mfussenegger/nvim-dap" })

		use({
			"rcarriga/nvim-dap-ui",
			requires = { "mfussenegger/nvim-dap" },
			config = function()
				local dap, dapui = require("dap"), require("dapui")
				-- Open DAP UI automatically
				dapui.setup({
					icons = { expanded = "▾", collapsed = "▸" },
					mappings = {
						-- Use a table to apply multiple mappings
						expand = { "<CR>", "<2-LeftMouse>" },
						open = "o",
						remove = "d",
						edit = "e",
						repl = "r",
					},
					sidebar = {
						-- You can change the order of elements in the sidebar
						elements = {
							-- Provide as ID strings or tables with "id" and "size" keys
							{
								id = "scopes",
								size = 0.40, -- Can be float or integer > 1
							},
							{ id = "breakpoints", size = 0.20 },
							{ id = "stacks", size = 0.20 },
							{ id = "watches", size = 0.20 },
						},
						size = 45,
						position = "left", -- Can be "left", "right", "top", "bottom"
					},
					tray = {
						elements = { "repl" },
						size = 20,
						position = "bottom", -- Can be "left", "right", "top", "bottom"
					},
					floating = {
						max_height = nil, -- These can be integers or a float between 0 and 1.
						max_width = nil, -- Floats will be treated as percentage of your screen.
						border = "single", -- Border style. Can be "single", "double" or "rounded"
						mappings = {
							close = { "q", "<Esc>" },
						},
					},
					windows = { indent = 1 },
				})
				dap.listeners.after.event_initialized["dapui_config"] =
					function()
						dapui.open()
					end
				dap.listeners.before.event_terminated["dapui_config"] =
					function()
						dapui.close()
					end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end
				dap.defaults.fallback.terminal_win_cmd = "10split new"
				dap.set_log_level("TRACE")
				require("core.signs").set_dap_signs()
			end,
		})

		use({
			"theHamsta/nvim-dap-virtual-text",
			requires = { "mfussenegger/nvim-dap" },
			config = function()
				require("nvim-dap-virtual-text").setup({
					enabled = true, -- enable this plugin (the default)
					enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
					highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
					highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
					show_stop_reason = true, -- show stop reason when stopped for exceptions
					commented = false, -- prefix virtual text with comment string
					-- experimental features:
					virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
					all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
					virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
					virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
					-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
				})
			end,
		})

		use({
			"mfussenegger/nvim-dap-python",
			requires = { "mfussenegger/nvim-dap" },
			config = function()
				require("dap-python").setup(
					"~/.pyenv/versions/debugpy/bin/python"
				)
			end,
		})

		use({ "bfredl/nvim-ipy" }) -- ipython integration

		use({ "metakirby5/codi.vim" }) -- code scratchpad

		use({ "folke/lua-dev.nvim" }) -- lua/nvim developer tools

		use({ -- GDB
			"sakhnik/nvim-gdb",
			run = "bash ./install.sh",
		})

		use({ -- Test runner
			"rcarriga/vim-ultest",
			requires = "vim-test/vim-test",
			run = ":UpdateRemotePlugins",
		})

		use({  -- Run code snippets
			"michaelb/sniprun",
			run = "bash ./install.sh",
			config = function()
				require("sniprun").setup({
					selected_interpreters = { "Python" },
					repl_enable = { "Python" },
				})
			end,
		})

		use({  -- Marks and Bookmarks
			"chentau/marks.nvim",
			config = function()
				require("config.marks")
			end,
		})

		use({  -- Completion and Snippets
			"hrsh7th/nvim-cmp",
			requires = {
				-- "hrsh7th/cmp-vsnip",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
				"saadparwaiz1/cmp_luasnip",
				"ray-x/cmp-treesitter",
				"onsails/lspkind-nvim",
				"f3fora/cmp-spell",
				"lukas-reineke/cmp-rg",
				"petertriho/cmp-git",
			},
			config = function()
				require("config.completion")
			end,
		})

		use({  -- Lua-based snippet engine
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			before = "nvim-cmp",
			config = function()
				local luasnip = require("luasnip")
				luasnip.config.set_config({
					history = true,
					updateevents = "TextChanged,TextChangedI",
				})
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		})

		use({
			"benfowler/telescope-luasnip.nvim",
			before = "telescope.nvim",
		})

		use({ -- Github integration
			"pwntester/octo.nvim",
			config = function()
				require("config.octo-nvim")
			end,
		})

		use({ -- git changes in sign column
			"lewis6991/gitsigns.nvim",
			config = function()
				require("config.gitsigns")
			end,
		})

		use({ "ruifm/gitlinker.nvim" })

		use({  ---Status bars
			"akinsho/bufferline.nvim",
			tag = "*",
			config = function()
				require("config.buffline")
			end,
		})

		use({
			"nvim-lualine/lualine.nvim",
			requires = {
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("config.lualine")
			end,
		})

		use({  -- save useful cheatsheets
			"sudormrfbin/cheatsheet.nvim",
			after = "telescope.nvim",
			config = function()
				require("cheatsheet").setup()
				require("telescope").load_extension("cheatsheet")
			end,
		})

		use({  -- Enhanced comments
			"folke/todo-comments.nvim",
			config = function()
				require("todo-comments").setup({
					merge_keywords = true,
					keywords = {
						WARNING = { icon = " ", color = "warning" },
					},
					highlight = {
						pattern = [[.*<(KEYWORDS)\s*]],
						keyword = "bg",
						comments_only = true,
					},
					search = {
						pattern = [[\b(KEYWORDS)\b]],
					},
				})
			end,
		})

		use({  -- Pretty notification windows/popups
			"rcarriga/nvim-notify",
			config = function()
				require("config.notify")
			end,
		})

		use({  -- Project manager
			"ahmedkhalf/project.nvim",
			config = function()
				require("config.project")
			end,
		})

		use({ "machakann/vim-sandwich" })  -- Split file explorer

		use({  -- Splash Screen/Dashboard
			"goolord/alpha-nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("config.dashboard")
			end,
		})

		use({
			"VonHeikemen/fine-cmdline.nvim",
			requires = "MunifTanjim/nui.nvim",
		})

		use({
			"akinsho/toggleterm.nvim",
			event = "BufWinEnter",
			branch = "main",
			config = function()
				require("config.toggle-term")
			end,
		})

		use({ "nikvdp/neomux" })

        use({  -- Keybinding helper
          "mrjones2014/legendary.nvim",
          config = function()
            require('legendary').setup()
          end
        })

		use({
			"folke/which-key.nvim",
			config = function()
				require("config.which-key-nvim")
			end,
		})

		use({  -- Smooth Scrolling
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup({
					easing_function = "quadratic",
				})
			end,
		})

		use({ "rktjmp/lush.nvim" })

		use({
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				require("config.catppuccin-theme")
			end,
		})

		use({ "mcchrish/zenbones.nvim" })

		use({ "rebelot/kanagawa.nvim" })

		use({
			"EdenEast/nightfox.nvim",
			config = function()
				require("config.nightfox")
			end,
		})

		use({
			"folke/tokyonight.nvim",
			branch = "main",
		})

		use({
			"rose-pine/neovim",
			as = "rose-pine",
			config = function()
				require("config.rose-pine-theme")
			end,
		})

		if Packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn =  function()
              return require("packer.util").float({ border = "single" })
            end
		},
	},
})