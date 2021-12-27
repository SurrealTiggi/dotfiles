return function()
  require('indent_blankline').setup {
    char = '', -- ┆ ┊ 
    show_foldtext = false,
    show_current_context = true,
    show_current_context_start = true,
    show_first_indent_level = true,
    filetype_exclude = {
      'startify',
      'dashboard',
      'log',
      'fugitive',
      'gitcommit',
      'packer',
      'vimwiki',
      'markdown',
      'json',
      'help',
      'NvimTree',
      'git',
      'TelescopePrompt',
      'undotree',
      '', -- for all buffers without a file type
    },
    buftype_exclude = { 'terminal', 'nofile' },
    context_patterns = {
      'class',
      'function',
      'method',
      'block',
      'list_literal',
      'selector',
      '^if',
      '^table',
      'if_statement',
      'while',
      'for',
    },
  }
end
