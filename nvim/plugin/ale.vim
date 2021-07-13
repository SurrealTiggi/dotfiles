""" ALE linter
let g:ale_linters = {
      \ 'go': ['golangci-lint'],
      \ 'python': ['flake8'],
      \ 'terraform': ['terraform'],
      \ 'markdown': ['mdl', 'writegood'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'css': ['stylelint'],
      \ 'html': ['htmlhint'],
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'python': ['isort', 'black'],
      \ 'terraform': ['terraform'],
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'html': ['prettier'],
      \ 'css': ['stylelint', 'prettier'],
      \}

let g:ale_fix_on_save = 1
let g:ale_go_golangci_lint_options = '--fast'
" let g:ale_python_black_options = '-l 79' " 88 is the default
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'
" let g:ale_python_flake8_options = '--max-complexity 10'
" let g:ale_python_flake8_options = '--max-complexity 10 --max-line-length 88'

let g:ale_echo_msg_error_str = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_format = '%severity% [%linter%:%code%] %s'
" let g:ale_sign_warning = ""
" let g:ale_sign_error = "﯇"
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
