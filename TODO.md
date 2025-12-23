# TODO

This file tracks high-level tasks and plugin experiments for the dotfiles repository.

> **Note:** Small tweaks and inline code improvements are kept as inline comments in the code itself.

## High Priority

### Installation & Bootstrap

- [ ] Improve README documentation
- [ ] Add Makefile commands for common post-bootstrap tasks (re-run ansible, testing, etc)
  - Reference: https://github.com/siyelo/laptop
- [ ] Ensure we account for WORK variable properly everywhere (including zsh aliases)

## Ansible & Configuration Management

- [ ] Auto-refresh terminal after dotfiles stow (exec zsh)
- [ ] Auto-run `nvim --headless "+Lazy! sync" +qa` after bootstrap
- [ ] Compare p10k-lean config and pull down .p10k-lean to avoid config wizard
- [ ] Automate keyboard shortcuts setup (currently manual in System Settings)

## Neovim

### Major Enhancements

- [ ] Prettify lualine and bufferline (add LSP info, better formatting)
  - Reference: https://github.com/nvim-lualine/lualine.nvim#screenshots
- [ ] Review and modernize all keymaps for consistency
- [ ] Audit and drop remaining unmaintained plugins
- [ ] Migrate null-ls -> none-ls (if still needed) or try efm https://github.com/olimorris/dotfiles/commit/bac18fb2338d8a97418787acfeac346246f515be

### Plugins to Try

- [ ] https://github.com/folke/sidekick.nvim - AI integration with Claude
- [ ] https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
- [ ] https://github.com/numToStr/Comment.nvim - Better commenting
- [ ] Alternative status lines: feline-nvim/feline.nvim, windline.nvim
- [ ] https://github.com/alex-popov-tech/store.nvim - Store for nvim
- [ ] https://github.com/nvim-mini/mini.nvim/
- [ ] https://github.com/dnlhc/glance.nvim better peeking (possibly abandoned)
- [ ] https://github.com/stevearc/oil.nvim
- [ ] inspo https://dotfiles.substack.com/p/29-gonzalo-stoll
- [ ] Better inlay hints https://vinnymeller.com/posts/neovim_nightly_inlay_hints/
- [ ] more inspo https://altf4.blog/blog/2024-02-25-development-environment-winter-2024-edition/

## Tmux

- [ ] Refactor my-theme.tmux (move colors to dedicated section, consolidate helpers)

## Completed

**2025-12 Session:**

- [x] Fixed install.sh (DOTFILES bug, curl check, Brewfile download, race conditions)
- [x] Switched from Poetry to uv for Python/Ansible management
- [x] Removed pyenv (redundant with asdf)
- [x] Optimized zsh PATH management (cached HOMEBREW_PREFIX)
- [x] Removed cosmic-ui (unmaintained, replaced with native LSP)
- [x] Cleaned up DELETE*ME*\* files and directories
- [x] Removed obsolete TODOs (lspsaga, PackerSync)
- [x] Removed tmux backup files
- [x] Created centralized TODO.md tracking
