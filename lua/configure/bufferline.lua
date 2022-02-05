local M = {}

function M.default_config()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  bufferline.setup({
    options = {
      numbers = "buffer_id",
      close_command = "bdelete! %d",
      right_mouse_command = nil,
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      indicator_icon = "▎",
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 18,
      max_prefix_length = 15,
      tab_size = 10,
      diagnostics = false,
      custom_filter = function(bufnr)
        -- if the result is false, this buffer will be shown, otherwise, this
        -- buffer will be hidden.

        -- filter out filetypes you don't want to see
        local exclude_ft = { "qf", "fugitive", "git" }
        local cur_ft = vim.bo[bufnr].filetype
        local should_filter = vim.tbl_contains(exclude_ft, cur_ft)

        if should_filter then
          return false
        end

        return true
      end,
      show_buffer_icons = false,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      separator_style = "bar",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      sort_by = "id",
    },
  })
end

function M.astro_config()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  local colors = require('core.colors').bufferline_gruvbox

  bufferline.setup({
    options = {
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      buffer_close_icon = "",
      modified_icon = "",
      close_icon = "",
      show_close_icon = true,
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
      diagnostics = false,
    },

    highlights = {
      background = {
        guifg = colors.grey_1,
        guibg = colors.black_2,
      },

      -- Buffers
      buffer_selected = {
        guifg = colors.grey,
        guibg = colors.black,
        gui = colors.none,
      },
      buffer_visible = {
        guifg = colors.grey,
        guibg = colors.black,
      },

      -- Diagnostics
      error = {
        guifg = colors.red_1,
        guibg = colors.red_1,
      },
      error_diagnostic = {
        guifg = colors.red_1,
        guibg = colors.red_1,
      },

      -- Close buttons
      close_button = {
        guifg = colors.grey_1,
        guibg = colors.black_2,
      },
      close_button_visible = {
        guifg = colors.grey_2,
        guibg = colors.black,
      },
      close_button_selected = {
        guifg = colors.red,
        guibg = colors.black,
      },
      fill = {
        guifg = colors.grey_1,
        guibg = colors.black_2,
      },
      indicator_selected = {
        guifg = colors.black,
        guibg = colors.black,
      },

      -- Modified
      modified = {
        guifg = colors.red,
        guibg = colors.black_2,
      },
      modified_visible = {
        guifg = colors.grey,
        guibg = colors.black,
      },
      modified_selected = {
        guifg = colors.green,
        guibg = colors.black,
      },

      -- Separators
      separator = {
        guifg = colors.black_2,
        guibg = colors.black_2,
      },
      separator_visible = {
        guifg = colors.black,
        guibg = colors.black,
      },
      separator_selected = {
        guifg = colors.black_2,
        guibg = colors.black_2,
      },

      -- Tabs
      tab = {
        guifg = colors.grey,
        guibg = colors.black,
      },
      tab_selected = {
        guifg = colors.black,
        guibg = colors.black,
      },
      tab_close = {
        guifg = colors.black,
        guibg = colors.black,
      },
    },
  })
end

return M
