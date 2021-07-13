""" vim-go
let g:go_def_mapping_enabled = 0      " Let coc-go handle mappings
let g:go_code_completion_enabled = 0  " Let coc-go handle completion
let g:go_gopls_options = ['-remote=auto']
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor
let g:go_auto_sameids = 1             " Highlight matching names in viewport
let g:go_doc_popup_window = 1         " use a popup window for :GoDoc [K]
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
