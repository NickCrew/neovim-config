require("indent_blankline").setup({
  buftype_exclude = {
    "NvimTree",
    "terminal",
    "term",
    "packer",
    "gitcommit",
    "fugitive",
    "nofile",
    "floatline",
  },
  filetype_exclude = {
    "NvimTree",
    "terminal",
    "term",
    "packer",
    "gitcommit",
    "fugitive",
    "nofile",
    "floatline",
  },
  context_patterns = {
    "class",
    "function",
    "method",
    "block",
    "list_literal",
    "selector",
    "^if",
    "^table",
    "if_statement",
    "while",
    "for",
    "object",
    "start_tag",
    "open_tag",
    "element",
  },
  show_first_indent_level = true,
  show_current_context = true,
  show_trailing_blankline_indent = false,
})
