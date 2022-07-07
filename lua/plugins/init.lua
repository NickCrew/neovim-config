-- lua/plugins/init.lua
--
-- Setup plugins

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
  max_jobs = 10,
})

return packer.startup({
  function(use)
    -- Packer itself
    use({ "wbthomason/packer.nvim" })

    use({ "Shatur/neovim-ayu" })

    use({ "sainnhe/everforest" })

    use({ "shaunsingh/moonlight.nvim" })

    use({ "gruvbox-community/gruvbox" })

    use({ "shaunsingh/nord.nvim" })

    use({ "sainnhe/sonokai" })
    -- install without yarn or npm
    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
    })

    use({ "shaunsingh/seoul256.nvim" })

    use({ "famiu/nvim-reload" })

    use({ "andymass/vim-matchup" })

    use({ "chaoren/vim-wordmotion" })

    use({ "matze/vim-move" })

    use({ "antoinemadec/FixCursorHold.nvim" })

    use({ "EthanJWright/vs-tasks.nvim" }) -- launch.json support

    -- use({ "github/copilot.vim" })

    use({ "kyazdani42/nvim-web-devicons" })

    use({ "tpope/vim-commentary" })

    use({ "andrewradev/switch.vim" })

    use({ "simnalamburt/vim-mundo" })

    use({ "b0o/schemastore.nvim" })

    use({ "ellisonleao/glow.nvim" }) -- markdown preview

    use({ "rktjmp/lush.nvim" })

    use({ "RishabhRD/popfix" })

    use({ "folke/lua-dev.nvim" }) -- lua/nvim developer tools

    use({ "metakirby5/codi.vim" }) -- code scratchpad

    use({
      "chipsenkbeil/distant.nvim",
      config = function()
        require("distant").setup()
      end,
    })

    use({
      "esensar/nvim-dev-container",
      config = function()
        require("devcontainer").setup({})
      end,
    })

    use({ "mfussenegger/nvim-dap" })

    use({ -- clipboard history
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
        require("telescope").load_extension("neoclip")
      end,
    })

    use({
      "0styx0/abbreinder.nvim",
      requires = {
        {
          "0styx0/abbremand.nvim",
          module = "abbremand", -- if want to lazy load
        },
      },
      config = function()
        require("config.abbreinder-nvim")
      end,
      event = "BufRead", -- if want lazy load
    })

    use({ -- LSP Symbol Drawer
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

    use({ -- Quick movements
      "phaazon/hop.nvim",
      config = function()
        require("hop").setup({
          case_insensitive = true,
          char2_fallback_key = "<CR>",
        })
      end,
    })

    use({ -- Sneak/quick movements
      "ggandor/leap.nvim",
      requires = "tpope/vim-repeat",
      config = function()
        require("leap").set_default_keymaps()
      end,
    })

    use({
      "ThePrimeagen/harpoon",
      before = "telescope.nvim",
      config = function()
        require('config.harpoon')
      end
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

    use({ -- RESTful API and HTTP Client
      "NTBBloodbath/rest.nvim",
      config = function()
        require("rest-nvim").setup({
          result_split_horizontal = false, -- Open request results in a horizontal split
          skip_ssl_verification = false, -- Skip SSL verification, useful for unknown certificates
          highlight = { -- Highlight request on run
            enabled = true,
            timeout = 150,
          },
          result = { -- toggle showing URL, HTTP info, headers at top the of result window
            show_url = true,
            show_http_info = true,
            show_headers = true,
          },
          jump_to_request = false, -- Jump to request line on run
          env_file = ".envrc",
          custom_dynamic_variables = {},
          yank_dry_run = true,
        })
      end,
    })

    use({ -- Powerful find and replace
      "windwp/nvim-spectre",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("spectre").setup()
      end,
    })

    use({ -- Smart delimiters and pairs
      "windwp/nvim-autopairs",
      config = function()
        require("config.autopairs")
      end,
    })

    use({ -- Popup preview window for LSP
      "rmagatti/goto-preview",
      event = "BufEnter",
      config = function()
        require("config.gotopreview")
      end,
    })

    use({ -- Project Drawer
      "lambdalisue/fern.vim",
      requires = {
        "yuki-yano/fern-preview.vim",
        "lambdalisue/fern-hijack.vim",
        "lambdalisue/fern-mapping-quickfix.vim",
        "lambdalisue/nerdfont.vim",
        "lambdalisue/glyph-palette.vim",
        "lambdalisue/fern-renderer-nerdfont.vim",
        "lambdalisue/fern-git-status.vim",
        "lambdalisue/fern-bookmark.vim",
      },
    })

    use({ -- Better quickfix window
      "kevinhwang91/nvim-bqf",
      ft = "qf",
      config = function()
        require("bqf").setup()
      end,
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
          sources = {
            -- diagnostics
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.diagnostics.pylint,
            null_ls.builtins.diagnostics.yamllint,
            -- formatting
            null_ls.builtins.formatting.yapf,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.stylua,
            -- code actions
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.code_actions.gitsigns,
          },
        })
      end,
    })

    use({
      {
        "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
        "ray-x/lsp_signature.nvim",
        "simrat39/rust-tools.nvim",
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        "folke/lsp-colors.nvim",
        "nvim-lua/lsp-status.nvim",
        "kosayoda/nvim-lightbulb",
      },
      {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
      },
      {
        "williamboman/nvim-lsp-installer"
      },
      {
        "neovim/nvim-lspconfig",
        event = "BufEnter",
        config = function()
          require("config.lsp")
        end,
      },
    })

    use({ -- Dim parts of your code you're not workingon
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup({})
      end,
    })

    use({ -- Show status of language server loading in buffer
      "j-hui/fidget.nvim",
      event = "BufEnter",
      config = function()
        require("fidget").setup({
          sources = {
            code_action = {
              ignore = true,
            },
          },
        })
      end,
    })

    use({ -- Smart Session Management
      "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      module = "persistence",
      config = function()
        require("persistence").setup()
      end,
    })

    use({ -- Syntax highlighting and parsiging
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

    use({ -- Docstring generator
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
      requires = "telescope.nvim",
      config = function()
        require("refactoring").setup()
        require("telescope").load_extension("refactoring")
      end,
    })

    use({ -- treesitter based colorizing
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

    use({ -- Enhance LSP Diagnostics
      "folke/trouble.nvim",
      before = "telescope.nvim",
      config = function()
        require("config.trouble")
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

    use({
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        local dapui = require("dapui")
        local dap = require("dap")
        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
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

    use({ -- GDB
      "sakhnik/nvim-gdb",
      run = "bash ./install.sh",
    })

    use({ -- Run code snippets
      "michaelb/sniprun",
      run = "bash ./install.sh",
    })

    use({ -- Completion and Snippets
      "hrsh7th/nvim-cmp",

      requires = {
        {
          "tzachar/cmp-tabnine",
          run = "./install.sh",
          requires = "hrsh7th/nvim-cmp",
        },
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        -- "hrsh7th/cmp-copilot",
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

    use({
      "rafamadriz/friendly-snippets",
    })

    use({ -- Lua-based snippet engine
      "L3MON4D3/LuaSnip",
      before = "nvim-cmp",
      config = function()
        require("config.luasnip")
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

    use({ ---Status bars
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

    use({ -- save useful cheatsheets
      "sudormrfbin/cheatsheet.nvim",
      after = "telescope.nvim",
      config = function()
        require("cheatsheet").setup()
        require("telescope").load_extension("cheatsheet")
      end,
    })

    use({ -- Pretty notification windows/popups
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup({
          level = "info",
          stages = "fade_in_slide_out",
          timeout = 1500,
          background_colour = "#2E3440",
          icons = {
            ERROR = "",
            WARN = "",
            INFO = "",
            DEBUG = "",
            TRACE = "✎",
          },
        })
      end,
    })

    use({ -- Project manager
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

    use({ "machakann/vim-sandwich" }) -- Split file explorer

    use({ -- Splash Screen/Dashboard
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
       require('config.dashboard') 
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

    use({ -- Keybinding helper
      "mrjones2014/legendary.nvim",
      before = "which-key.nvim",
      config = function()
        require("legendary").setup()
      end,
    })

    use({
      "folke/which-key.nvim",
      config = function()
        require("config.which-key-nvim")
      end,
    })

    use({ -- Smooth Scrolling
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup({
          easing_function = "quadratic",
        })
      end,
    })

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
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
