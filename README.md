# dotfiles [Zsh + Neovim + Everything Else]

```
       __      __  _____ __
  ____/ /___  / /_/ __(_) /__  _____
 / __  / __ \/ __/ /_/ / / _ \/ ___/
/ /_/ / /_/ / /_/ __/ / /  __(__  )
\__,_/\____/\__/_/ /_/_/\___/____/

```

[![forthebadge](https://forthebadge.com/images/badges/60-percent-of-the-time-works-every-time.svg)](https://forthebadge.com)

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

## Getting Started

This repo contains my personal dotfiles, as well as scripts and ansible playbooks for bootstrapping and maintenance.

```
bash <(curl -s https://surrealtiggi.github.io/dotfiles/install.sh)
```

## What's Included

**Automated via Ansible:**

- **Shell**: Zsh + Oh My Zsh + Powerlevel10k theme
- **Editor**: Neovim with Lazy.nvim plugin manager, LSP, and treesitter
- **Terminal**: Alacritty (or iTerm2) with custom configuration
- **Multiplexer**: Tmux with custom theme
- **Version Manager**: ASDF for Go, Node, Python, Ruby, Terraform
- **Package Manager**: Homebrew + Brewfile for declarative package management
- **Dotfiles**: Managed via GNU Stow for easy symlinking

**Manual Setup:**

- macOS system (install script is macOS-only)

## Screenshots

![alt text](https://raw.githubusercontent.com/SurrealTiggi/dotfiles/master/term.png)

## Credits

Inspiration over the years:

- [NVChad](https://nvchad.com/)
- [LunarVim](https://www.lunarvim.org/)
- [kyoto.nvim](https://github.com/samharju/kyoto.nvim)
- [martinsione/dotfiles](https://github.com/martinsione/dotfiles)
- [ayamir/nvimdots](https://github.com/ayamir/nvimdots)
- [r/neovim](https://www.reddit.com/r/neovim/)
- [tmux-plugin-sysstat](https://github.com/samoshkin/tmux-plugin-sysstat)
- [tmux-power](https://github.com/wfxr/tmux-power)
- [FelixKratz's dotfiles](https://github.com/FelixKratz/)
- [Lissy93's dotfiles](https://github.com/Lissy93/Lissy93)
- [geerlingguy's mac collection](https://github.com/geerlingguy/)

## TODO

See [TODO.md](TODO.md) for all outstanding tasks and enhancements.

## Post-Install Manual Steps

<details>
<summary>macOS Configuration</summary>

- Log in to primary Apple ID
- Add Finder sidebar folders (customize as needed)
- Configure keyboard shortcuts in System Settings (not yet automated)

</details>
