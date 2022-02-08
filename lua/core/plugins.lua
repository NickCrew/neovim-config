-- lua/plugins.lua
--

local vim = vim

-- Detect changes to this file and run :PackerCompile
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local fn = vim.fn
local packer_bootstrap = false
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

return require("packer").startup(function(use)
  -- Packer itself
  use({ "wbthomason/packer.nvim" })

  -- Do more faster
  use({ "lewis6991/impatient.nvim" })

  use({ "dstein64/vim-startuptime" })

  use({ "famiu/nvim-reload" })

  -- Popup preview window for LSP
  use({
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({})
    end,
  })

  -- Language Support
  use({
    "neovim/nvim-lspconfig",
    event = "BufRead",
    requires = {
      "RishabhRD/popfix",
      "jubnzv/virtual-types.nvim",
      "ray-x/lsp_signature.nvim",
      "williamboman/nvim-lsp-installer",
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "folke/lsp-colors.nvim",
      "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    },
    config = function()
      require("lsp")
    end,
  })

  use({
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  })

  use({
    "kosayoda/nvim-lightbulb",
  })

  -- Syntax highlighting
  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "p00f/nvim-ts-rainbow",
      "romgrk/nvim-treesitter-context",
      "nvim-treesitter/playground",
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
      require("configure.treesitter")
    end,
  })

  use({
    "akinsho/nvim-toggleterm.lua",
    cmd = "ToggleTerm",
    config = function()
      require("configure.toggleterm").config()
    end,
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

  -- Telescope plugins
  use({
    "nvim-telescope/telescope-vimspector.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "jvgrootveld/telescope-zoxide",
    "nvim-telescope/telescope-github.nvim",
    {
      "nvim-telescope/telescope-dap.nvim",
      requires = "mfussenegger/nvim-dap",
    },
    before = "telescope.nvim",
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "folke/trouble.nvim",
      "tami5/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "mrjones2014/dash.nvim", run = "make install" },
    },
    config = function()
      require("configure.telescope")
    end,
  })

  use({
    "mfussenegger/nvim-dap-python",
    ft = "python",
    requires = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-python").setup("~/.pyenv/versions/debugpy/bin/python")
    end,
  })

  use({
    "Pocco81/DAPInstall",
    config = function()
      local di = require("dap-install")
      di.config("jsnode", {}, "python", "codelldb")
    end,
  })

  use({
    "jbyuki/one-small-step-for-vimkind",
    after = "nvim-dap",
    config = function()
      local dap = require("dap")
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
          host = function()
            local value = vim.fn.input("Host [127.0.0.1]: ")
            if value ~= "" then
              return value
            end
            return "127.0.0.1"
          end,
          port = function()
            local val = tonumber(vim.fn.input("Port: "))
            assert(val, "Please provide a port number")
            return val
          end,
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host, port = config.port })
      end
    end,
  })

  -- VSCode Debug Adapter Compatibility
  use({
    "mfussenegger/nvim-dap",
  })

  use({
    "theHamsta/nvim-dap-virtual-text",
    requires = {

      "mfussenegger/nvim-dap",
    },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  })

  -- User interface for DAP
  use({
    "rcarriga/nvim-dap-ui",
    requires = {

      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dapui").setup()
      -- -- Dap UI will open automatically
      local dap, dapui = require("dap"), require("dapui")
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

  -- Vimspector - alternative debugger
  use({
    "puremourning/vimspector",
    before = "telescope.nvim",
    config = function()
      require("configure.vimspector")
    end,
    disabled = true,
  })

  -- Gnu Debugger
  use({
    "sakhnik/nvim-gdb",
    run = "bash ./install.sh",
  })

  -- Test Runner
  use({
    "rcarriga/vim-ultest",
    requires = { "vim-test/vim-test" },
    run = ":UpdateRemotePlugins",
  })

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

  -- Marks and Bookmarks
  use({
    "chentau/marks.nvim",
    config = function()
      require("configure.marks")
    end,
  })

  use({
    "hrsh7th/vim-vsnip",
    "rafamadriz/friendly-snippets",
  })
  -- Completion and Snippets
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind-nvim",
    },
    config = function()
      require("configure.completion")
    end,
  })

  -- Git integration
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configure.gitsigns").config()
    end,
  })

  -- File tree
  use({
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      require("configure.nvim-tree")
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    after = "bufferline.nvim",
    config = function()
      require("configure.lualine")
    end,
  })
  use({
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("configure.bufferline")
    end,
  })

  -- Better buffer closing
  use({
    "moll/vim-bbye",
    after = "bufferline.nvim",
  })

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
      require("configure.indent-blankline")
    end,
  })

  -- Enhanced comments
  use({
    "folke/todo-comments.nvim",
    config = function()
      require("configure.todo-comments")
    end,
  })

  use({
    "rcarriga/nvim-notify",
    config = function()
      require("configure.nvim-notify")
    end,
  })

  use({
    "tpope/vim-vinegar",
  })

  -- Splash Screen
  use({
    "goolord/alpha-nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("configure.dashboard")
    end,
  })

  -- Tag and symbol sidebar
  use({ "liuchengxu/vista.vim" })

  -- FLoating command line
  use({ "voldikss/vim-floaterm" })

  use({
    "VonHeikemen/fine-cmdline.nvim",
    requires = "MunifTanjim/nui.nvim",
  })

  -- Index search results
  use({
    "kevinhwang91/nvim-hlslens",
    branch = "main",
    keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
    config = function()
      require("hlslens").setup({
        calm_down = true,
        nearest_only = true,
      })
    end,
  })

  -- Move code easily
  use({
    "matze/vim-move",
    setup = function() end,
  })

  -- Keybinding helper
  use({
    "folke/which-key.nvim",
    config = function()
      require("configure.which-key")
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
  use({ "chaoren/vim-wordmotion" })

  -- Formatting
  use({ "sbdchd/neoformat" })

  -- Easy commenting
  use({ "tpope/vim-commentary" })

  -- Improved history with tree-style viewer
  use({ "simnalamburt/vim-mundo" })

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
    config = function()
      require("cheatsheet").setup()
    end,
  })

  -- Project manager
  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end,
  })

  -- Wrapping/delimiters
  use({
    "machakann/vim-sandwich",
    {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({})
      end,
    },
  })

  -- Generate docs
  use({
    "danymat/neogen",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        enabled = true,
      })
    end,
  })

  -- Smooth Scrolling
  use({
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        easing_function = "quadratic",
      })
    end,
  })

  -- Markdown
  use({
    "ellisonleao/glow.nvim",
  })

  -- Themes
  use({
    "ellisonleao/gruvbox.nvim",
  })

  use({
    "luisiacc/gruvbox-baby",
    branch = "main",
  })

  use({
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        undercurl = true, -- enable undercurls
        commentStyle = "italic",
        functionStyle = "NONE",
        keywordStyle = "italic",
        statementStyle = "bold",
        typeStyle = "NONE",
        variablebuiltinStyle = "italic",
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        colors = {},
        overrides = {},
      })
    end,
  })
  use({
    "folke/tokyonight.nvim",
    branch = "main",
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
