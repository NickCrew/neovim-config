return {
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'folke/trouble.nvim',
    'tami5/sqlite.lua',
    'nvim-telescope/telescope-symbols.nvim',
    'jvgrootveld/telescope-zoxide',
    'nvim-telescope/telescope-github.nvim',
    'nvim-telescope/telescope-frecency.nvim',
    'nvim-telescope/telescope-vimspector.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-vimspector.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'mrjones2014/dash.nvim', run = 'make install' }
  },
  config = function()
    local trouble = require('trouble.providers.telescope')
    local actions = require('telescope.actions')
    local tele = require('telescope')

    tele.setup({
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--hidden',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--ignore-file',
          (vim.fn.stdpath('config') .. '/.telescope_ignore'),
        },
        prompt_prefix = '   ',
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        dynamic_preview_title = true,
        mappings = {
          i = { 
            ['<c-t>'] = trouble.open_with_trouble ,
            ['<esc>'] = actions.close,
          },
          n = { 
            ['<c-t>'] = trouble.open_with_trouble,
            ['<esc>'] = actions.close
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            'rg',
            '--hidden',
            '--no-heading',
            '--with-filename',
            '--files',
            '--column',
            '--smart-case',
            '--ignore-file',
            (vim.fn.stdpath('config') .. '/.telescope_ignore'),
            '--iglob',
            '!.git',
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
        -- even more opts
      },
      dash = {
          -- configure path to Dash.app if installed somewhere other than /Applications/Dash.app
          --dash_app_path = '/Applications/Dash.app/Contents/Resources/dashAlfredWorkflow',
          -- search engine to fall back to when Dash has no results, must be one of: 'ddg', 'duckduckgo', 'startpage', 'google'
          search_engine = 'ddg',
          -- debounce while typing, in milliseconds
          debounce = 0,
          -- map filetype strings to the keywords you've configured for docsets in Dash
          -- setting to false will disable filtering by filetype for that filetype
          -- filetypes not included in this table will not filter the query by filetype
          -- check src/lua_bindings/dash_config_binding.rs to see all defaults
          -- the values you pass for file_type_keywords are merged with the defaults
          -- to disable filtering for all filetypes,
          -- set file_type_keywords = false

          file_type_keywords = {
            dashboard = false,
            NvimTree = false,
            TelescopePrompt = false,
            terminal = false,
            packer = false,
            fzf = false,
            -- a table of strings will search on multiple keywords
            yaml = { 'yml' },
            javascript = { 'javascript', 'nodejs' },
            typescript = { 'typescript', 'javascript', 'nodejs' },
          },
        }
      },
    })

  tele.load_extension('zoxide')
  tele.load_extension('projects')
  tele.load_extension('vimspector')
  tele.load_extension('fzf')
  tele.load_extension('ui-select')
  tele.load_extension('cheatsheet')
  tele.load_extension('frecency')
  tele.load_extension('gh')
  tele.load_extension('dash')

  require('keymap').apply_telescope_keymaps()

  end,
}
