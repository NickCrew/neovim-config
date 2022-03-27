-- lua/plugins.lua
--
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

return packer.startup({
	function(use)
		-- Packer itself
		use({
			"wbthomason/packer.nvim",
		})

		-- Reload Noevim
		use({
			"famiu/nvim-reload",
		})

		use({
			"chipsenkbeil/distant.nvim",
			config = function()
				require("distant").setup({
					-- Applies Chip's personal settings to every machine you connect to
					--
					-- 1. Ensures that distant servers terminate with no connections
					-- 2. Provides navigation bindings for remote directories
					-- 3. Provides keybinding to jump into a remote file's parent directory
					["*"] = require("distant.settings").chip_default(),
				})
			end,
		})

		use({
			"knubie/vim-kitty-navigator",
			run = "cp ./*.py ~/.config/kitty/",
			disable = true,
		})

		-- Fix weirdness with cursor/hover delay
		use({
			"antoinemadec/FixCursorHold.nvim",
		})

		-- Cool icons
		use({
			"kyazdani42/nvim-web-devicons",
		})

		-- Improve % movement
		use({
			"andymass/vim-matchup",
		})

		-- RESTful API and HTTP Client
		use({
			"NTBBloodbath/rest.nvim",
			config = function()
				require("config.rest")
			end,
		})

		use({
			"windwp/nvim-spectre",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("spectre").setup()
			end,
		})

		-- less jarring buffer open close
		use({
			"luukvbaal/stabilize.nvim",
			config = function()
				require("stabilize").setup()
			end,
		})

		use({ "gennaro-tedesco/nvim-peekup" })

		-- Popup preview window for LSP
		use({
			"rmagatti/goto-preview",
			event = "BufEnter",
			config = function()
				require("goto-preview").setup({})
			end,
		})

		-- Better quickfix window
		use({
			"kevinhwang91/nvim-bqf",
			ft = "qf",
			config = function()
				require("bqf").setup()
			end,
		})

		-- Fuzzy finder binary
		use({
			"junegunn/fzf",
			run = function()
				vim.fn["fzf#install"]()
			end,
		})

		-- Better mark-based navigation
		use({
			"ThePrimeagen/harpoon",
			before = "telescope.nvim",
			config = function()
				require("config.harpoon-nvim")
			end,
		})

		-- Task runner supporting VS Code's launch.json
		use({
			"EthanJWright/vs-tasks.nvim",
			after = "telescope.nvim",
			config = function()
				require("vstask").setup({ use_harpoon = true })
			end,
		})

		-- Tag and symbol sidebar
		use({
			"stevearc/aerial.nvim",
			after = "telescope.nvim",
			config = function()
				require("config.aerial")
			end,
		})

		---- Language Server Support
		use({
			"neovim/nvim-lspconfig",
			event = "BufEnter",
			requires = {
				"RishabhRD/popfix",
				"jubnzv/virtual-types.nvim",
				"ray-x/lsp_signature.nvim",
				"williamboman/nvim-lsp-installer",
				"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
				"jose-elias-alvarez/nvim-lsp-ts-utils",
				"folke/lsp-colors.nvim",
				"nvim-lua/lsp-status.nvim",
				"simrat39/rust-tools.nvim",
			},
			config = function()
				require("lsp")
			end,
		})

		use({
			"folke/twilight.nvim",
			config = function()
				require("twilight").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})

		-- Show status of language server loading in buffer
		use({
			"j-hui/fidget.nvim",
			event = "BufEnter",
			config = function()
				require("fidget").setup()
			end,
		})

		-- Popup menu with recommendations
		use({
			"weilbith/nvim-code-action-menu",
			cmd = "CodeActionMenu",
		})

		-- Show a lightbulb in the signcolumn when code actions are available
		use({
			"kosayoda/nvim-lightbulb",
		})

		-- Refactoring based on treesitter
		use({
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
			config = function()
				require("refactoring").setup({})
			end,
		})

		use({
			"folke/lua-dev.nvim",
		})

		use({
			"folke/persistence.nvim",
			event = "BufReadPre", -- this will only start session saving when an actual file was opened
			module = "persistence",
			config = function()
				require("persistence").setup()
			end,
		})

		use({
			"andrewradev/switch.vim",
		})

		use({
			"wellle/targets.vim",
		})

		-- Syntax highlighting and parsiging
		use({
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

		use({
			"famiu/bufdelete.nvim",
		})

		-- Search and command palette
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

		-- Alternative Graphical Debugger

		use({ "nvim-telescope/telescope-vimspector.nvim" })
		use({
			"puremourning/vimspector",
			requires = { "nvim-telescope/telescope-vimspector.nvim" },
			config = function()
				require("config.vimspector")
			end,
			opt = true,
			disable = false,
		})

		-- Enhance LSP Diagnostics
		use({
			"folke/trouble.nvim",
			before = "telescope.nvim",
			config = function()
				require("trouble").setup()
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
				{
					"nvim-telescope/telescope-dap.nvim",
					requires = "mfussenegger/nvim-dap",
				},
				"nvim-telescope/telescope-live-grep-raw.nvim",
				"nvim-telescope/telescope-node-modules.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				"nvim-telescope/telescope-symbols.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
				{ "mrjones2014/dash.nvim", run = "make install" },
			},
			config = function()
				require("config.telescope")
			end,
		})

		-- Graphical debugger compatible with VS Code
		use({
			"mfussenegger/nvim-dap",
			requires = {
				"rcarriga/nvim-dap-ui",
				"theHamsta/nvim-dap-virtual-text",
				"mfussenegger/nvim-dap-python",
				"Pocco81/DAPInstall",
			},
			config = function()
				require("config.nvim-dap")
			end,
		})

		-- Gnu Debugger
		use({
			"sakhnik/nvim-gdb",
			run = "bash ./install.sh",
		})

		-- Test Runner
		use({
			"rcarriga/vim-ultest",
			ft = { "python" },
			requires = { "vim-test/vim-test", ft = { "python" } },
			run = ":UpdateRemotePlugins",
		})

		-- Run any code snippet
		use({
			"michaelb/sniprun",
			run = "bash ./install.sh",
			config = function()
				require("sniprun").setup({
					selected_interpreters = { "Python" },
					repl_enable = { "Python" },
				})
			end,
		})

		-- Interactive scratchpad
		use({
			"metakirby5/codi.vim",
		})

		-- Marks and Bookmarks
		use({
			"chentau/marks.nvim",
			config = function()
				require("config.marks")
			end,
		})

		-- AI completion source
		use({
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			requires = "hrsh7th/nvim-cmp",
			config = function()
				local tabnine = require("cmp_tabnine.config")
				tabnine:setup({
					max_lines = 1000,
					max_num_results = 20,
					sort = true,
					run_on_every_keystroke = true,
					snippet_placeholder = "..",
					ignored_file_types = { -- default is not to ignore
						-- uncomment to ignore in lua:
						-- lua = true
					},
				})
			end,
		})

		-- Completion and Snippets
		use({
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
				"ray-x/cmp-treesitter",
				"onsails/lspkind-nvim",
				"lukas-reineke/cmp-rg",
			},
			config = function()
				require("config.completion")
			end,
		})

		-- Lua-based snippet engine
		use({
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		})

		-- Telescope extension for LuaSnip
		use({
			"benfowler/telescope-luasnip.nvim",
			before = "telescope",
			module = "telescope._extensions.luasnip", -- if you wish to lazy-load
		})

		-- VS Code snippets for various languages
		use({
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").load()
			end,
		})

		use({
			"b0o/schemastore.nvim",
		})

		use({
			"pwntester/octo.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("config.octo-nvim")
			end,
		})

		use({
			"ruifm/gitlinker.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("gitlinker").setup()
			end,
		})

		-- Local Git integration
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("config.gitsigns").config()
			end,
		})

		-- Show inline git messages
		use({ "rhysd/git-messenger.vim", cmd = "GitMessenger" })


        use({
          "nvim-neo-tree/neo-tree.nvim",
          branch = "v2.x",
          requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim"
          },
          config = require('config.neo-tree-nvim')
        })

		-- Status bar
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("config.lualine")
			end,
		})

		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
		})

		-- Colorizer hex colors
		use({
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

		-- Indent Guides
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("config.indent-blankline")
			end,
			disable = true,
		})

		-- Enhanced comments
		use({
			"folke/todo-comments.nvim",
			config = function()
				require("config.todo-comments")
			end,
		})

		-- Pretty notification windows/popups
		use({
			"rcarriga/nvim-notify",
			config = function()
				require("config.nvim-notify")
			end,
		})

		-- Split file explorer
		use({
			"lambdalisue/fern.vim",
			requires = {
				"yuki-yano/fern-preview.vim",
				"lambdalisue/fern-hijack.vim",
				"lambdalisue/nerdfont.vim",
				"lambdalisue/fern-renderer-nerdfont.vim",
				"lambdalisue/fern-git-status.vim",
				"lambdalisue/fern-bookmark.vim",
			},
		})

		-- Splash Screen/Dashboard
		use({
			"goolord/alpha-nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("config.dashboard")
			end,
		})

		-- FLoating command line
		use({
			"numtostr/FTerm.nvim",
			config = function()
				require("config.fterm")
			end,
		})

		-- Run commands in an instant
		use({
			"VonHeikemen/fine-cmdline.nvim",
			requires = { "MunifTanjim/nui.nvim" },
		})

		-- Index search results
		use(require("config.hslens"))

		-- Move code easily
		use({ "matze/vim-move" })

		-- Keybinding helper
		use({
			"folke/which-key.nvim",
			config = function()
				require("config.which-key-nvim")
			end,
		})

		-- Better quickfix window
		use({
			"phaazon/hop.nvim",
			config = function()
				require("hop").setup({
					case_insensitive = true,
					char2_fallback_key = "<CR>",
				})
			end,
		})

		-- Movement
		use({
			"chaoren/vim-wordmotion",
		})

		-- Formatting
		use({
			"sbdchd/neoformat",
		})

		-- Easy commenting
		use({
			"tpope/vim-commentary",
		})

		-- Improved history with tree-style viewer
		use({
			"simnalamburt/vim-mundo",
		})

		-- Better pane navigation
		use({
			"numToStr/Navigator.nvim",
			config = function()
				require("Navigator").setup()
			end,
		})

		-- Help Remember stuff
		use({
			"sudormrfbin/cheatsheet.nvim",
			opt = true,
			cmd = "CheatSheet",
			config = function()
				require("cheatsheet").setup()
				require("telescope").load_extension("cheatsheet")
			end,
		})

		-- Project manager
		use({
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup({
					manual_mode = false,
					update_cwd = true,
					update_focused_file = {
						enable = true,
						update_cwd = true,
					},
					patterns = {
						".git",
					},
					exclude_dirs = {
						"~/.config/*",
						"~/.local/*",
					},
				})
			end,
		})

		-- Find matching pairs
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})

		-- Wrapping/delimiters
		use({ "machakann/vim-sandwich" })

		-- Generate docs
		use({
			"danymat/neogen",
			requires = "nvim-treesitter/nvim-treesitter",
			config = function()
				require("config.neogen-nvim")
			end,
		})

		-- Smooth Scrolling
		use({
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup({ easing_function = "quadratic" })
			end,
		})

		-- Markdown support with live preview inside nvim
		use({ "ellisonleao/glow.nvim" })

		-- Theme builder
		use({
			"rktjmp/lush.nvim",
		})

		-------------------------------
		-- Themes
		-------------------------------
		use({
			"rose-pine/neovim",
			as = "rose-pine",
		})

		use({
			"ellisonleao/gruvbox.nvim",
		})

		use({
			"EdenEast/nightfox.nvim",
		})

		use({
			"folke/tokyonight.nvim",
			branch = "main",
		})

		use({
			"shaunsingh/nord.nvim",
		})

		if Packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
