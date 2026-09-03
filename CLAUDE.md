# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS system configuration and bootstrapping. It uses Ansible for automation and Poetry for Python dependency management. The repository contains configuration files for various development tools and a complete system setup workflow.

## Key Commands

### Bootstrap System (Primary Installation)
```bash
# Full system bootstrap (installs Homebrew, apps, and runs Ansible)
bash <(curl -s https://surrealtiggi.github.io/dotfiles/install.sh)

# Or run locally if repository is already cloned
./install.sh
```

### Ansible Operations
```bash
# Install Python dependencies
poetry install

# Install required Ansible collections
poetry run ansible-galaxy collection install geerlingguy.mac

# Run full playbook (requires sudo password)
poetry run ansible-playbook ansible/playbook.yml --extra-vars="ansible_become_pass=PASSWORD" -i ansible/inventory

# Run specific tasks with tags
poetry run ansible-playbook ansible/playbook.yml -i ansible/inventory --tags asdf
poetry run ansible-playbook ansible/playbook.yml -i ansible/inventory --tags dotfiles
poetry run ansible-playbook ansible/playbook.yml -i ansible/inventory --tags terminal
poetry run ansible-playbook ansible/playbook.yml -i ansible/inventory --tags tmux
poetry run ansible-playbook ansible/playbook.yml -i ansible/inventory --tags homebrew
```

### Homebrew Package Management
```bash
# Install packages from Brewfile
brew bundle --file Brewfile

# Update all packages
brew update && brew upgrade
```

## Architecture and Structure

### Configuration Management
The repository uses a multi-layered approach:

1. **Ansible Automation**: Primary configuration management via `ansible/playbook.yml`
2. **Stow Symlinks**: Dotfiles are managed via GNU Stow for symlinking
3. **Homebrew**: Package installation via `Brewfile` and ansible configuration
4. **ASDF**: Version management for programming languages and tools

### Key Directories
- `ansible/`: Contains playbook, tasks, and configuration files
- `nvim/`: Neovim configuration using Lazy.nvim plugin manager
- `zsh/`: Shell configuration with Oh My Zsh and Powerlevel10k theme
- `tmux/`: Terminal multiplexer configuration
- `alacritty/`: Terminal emulator configuration
- `bin/`: Custom scripts and utilities
- `gitconfig/`: Git configuration files

### Ansible Task Organization
Tasks are modularized in `ansible/tasks/`:
- `dotfiles.yml`: Symlinks dotfiles using Stow
- `asdf.yml`: Installs and configures language version manager
- `terminal.yml`: Configures shell, plugins, and terminal tools
- `tmux.yml`: Sets up terminal multiplexer
- `homebrew.yml`: Managed by geerlingguy.mac.homebrew role

### Development Environment Stack
- **Shell**: Zsh with Oh My Zsh framework
- **Theme**: Powerlevel10k with custom configuration
- **Editor**: Neovim with Lazy.nvim plugin manager
- **Terminal**: Alacritty with custom themes
- **Multiplexer**: Tmux with custom configuration
- **Version Management**: ASDF for multiple language runtimes
- **Package Management**: Homebrew for macOS applications and CLI tools

### Language and Tool Versions (via ASDF)
As defined in `ansible/config.yml`:
- Go: 1.24.0
- Node.js: 22.16.0  
- Python: 3.11.0
- Poetry: 2.1.3
- Ruby: 3.4.4
- Terraform: 1.12.2

### Dotfiles Linking Strategy
Uses GNU Stow to create symlinks from repository directories to home directory:
- `stow alacritty` → `~/.config/alacritty/`
- `stow nvim` → `~/.config/nvim/`
- `stow zsh` → `~/.zshrc`, `~/.config/zsh/`
- `stow tmux` → `~/.tmux.conf`, `~/.config/tmux/`
- `stow gitconfig` → `~/.gitconfig`

## Neovim Configuration

The Neovim setup is a comprehensive development environment built on modern plugin architecture and LSP integration.

### Core Architecture
- **Plugin Manager**: Lazy.nvim for fast, lazy-loaded plugin management
- **LSP**: Mason.nvim + lspconfig for language server management
- **Configuration Structure**: Modular Lua-based configuration in `nvim/.config/nvim/`

### Directory Structure
```
nvim/.config/nvim/
├── init.lua                    # Main entry point, loads all modules
├── lazy-lock.json              # Plugin version lock file
└── lua/
    ├── init.lua                # Global variables and utilities
    ├── core/                   # Core configuration modules
    │   ├── colors.lua          # Color scheme definitions
    │   ├── lazy.lua            # Lazy.nvim bootstrapping
    │   ├── options.lua         # Vim options and settings
    │   └── symbols.lua         # UI symbols and icons
    ├── lsp-new/                # Modern LSP configuration
    │   ├── lspconfig.lua       # Language server configurations
    │   └── mason.lua           # LSP server installation management
    ├── plugins/                # Individual plugin configurations
    │   ├── conform.lua         # Code formatting (prettier, stylua, black, etc.)
    │   ├── nvim-cmp.lua        # Completion engine
    │   ├── telescope.lua       # Fuzzy finder
    │   ├── treesitter.lua      # Syntax highlighting
    │   ├── nvim-tree.lua       # File explorer
    │   ├── lualine.lua         # Status line
    │   ├── bufferline.lua      # Tab/buffer line
    │   ├── gitsigns.lua        # Git integration
    │   └── [other plugins]     # Various utility plugins
    └── user/                   # User-specific customizations
        ├── keybinds.lua        # Key mappings (Lua)
        ├── keybinds.vim        # Legacy key mappings (Vimscript)
        ├── functions.lua       # Custom utility functions
        ├── plugins.lua         # Plugin definitions and lazy.nvim setup
        └── misc.lua            # Colorscheme and miscellaneous settings
```

### Language Server Support
Configured LSPs via Mason.nvim in `lsp-new/mason.lua:8-25`:
- **Web**: `ts_ls`, `html`, `cssls`, `tailwindcss`, `emmet_ls`
- **Backend**: `gopls`, `pyright`, `rust_analyzer`
- **DevOps**: `bashls`, `terraformls`, `helm_ls`, `ansiblels`
- **Data**: `jsonls`, `jsonnet_ls`
- **Lua**: `lua_ls` (with Neovim API support)

### Code Formatting & Linting
Conform.nvim handles formatting in `plugins/conform.lua:4-24`:
- **Python**: `isort` + `black`
- **Go**: `gofumpt` + `goimports`
- **JavaScript/TypeScript**: `prettier`
- **Lua**: `stylua`
- **Terraform**: `terraform_fmt`
- **Shell**: `shfmt`
- **Universal**: `trim_whitespace` + `trim_newlines`

Format on save enabled with `<leader>mp` manual formatting.

### Plugin Categories

#### IDE Features (`user/plugins.lua:15-64`)
- **Telescope**: Fuzzy finding for files, symbols, and references
- **nvim-tree**: File explorer with Git integration
- **Trouble**: Diagnostics and error list
- **Gitsigns**: Git diff markers and blame
- **toggleterm**: Floating terminal integration

#### Language Support (`user/plugins.lua:66-98`)
- **nvim-cmp**: Intelligent completion with LSP, path, and snippet sources
- **Treesitter**: Advanced syntax highlighting and AST navigation
- **LuaSnip**: Snippet engine with completion integration
- **vim-helm**: Helm chart file detection

#### Aesthetics (`user/plugins.lua:163-246`)
- **Colorschemes**: Catppuccin (primary), Tokyo Night, Kanagawa
- **lualine**: Modern status line with LSP information
- **bufferline**: Enhanced buffer/tab display
- **nvim-notify**: Floating notifications
- **indent-blankline**: Indentation guides
- **vim-hexokinase**: Inline color preview

#### Development Tools (`user/plugins.lua:119-161`)
- **Codeium**: AI-powered code completion
- **todo-comments**: Highlight and navigate TODO/FIXME comments
- **goto-preview**: Definition preview without leaving context
- **sops.nvim**: Encrypted secrets editing
- **b64.nvim**: Base64 encoding/decoding

### Key Bindings
Primary mappings in `user/keybinds.lua:14-29`:
- **Leader Key**: `<Space>`
- **Navigation**: `gd` (definition), `gr` (references), `gs` (symbols)
- **LSP Actions**: `ga` (code actions), `grn` (rename), `K` (hover)
- **Diagnostics**: `gl` (workspace diagnostics), `<C-j>/<C-k>` (next/prev)
- **Preview**: `gp` (goto preview), `gP` (close previews)
- **Format**: `<leader>mp` (format file/selection)

### Configuration Philosophy
- **Performance**: Lazy-loaded plugins with event-based loading
- **Modern LSP**: Native Neovim LSP with Mason management
- **Modularity**: Each feature in separate, focused modules
- **Extensibility**: Clear plugin categorization for easy additions
- **Consistency**: Unified keybinding scheme with mnemonic prefixes

### Migration Notes
The configuration is transitioning from legacy LSP setup:
- Old LSP config in `DELETE_ME_lsp/` (deprecated)
- New LSP config in `lsp-new/` (current)
- Some legacy Vimscript keybinds still loaded via `keybinds.vim`

### Common Operations
```bash
# Open Neovim in project
nvim .

# Key sequences for development:
# <Space>ff  -> Find files (Telescope)
# <Space>fg  -> Find in files (grep)
# <Space>fb  -> Find buffers
# <Space>e   -> Toggle file explorer
# <Space>ca  -> Code actions
# <Space>rn  -> Rename symbol
```

## Herdr

Terminal multiplexer, migrated from tmux. Config is `herdr/.config/herdr/config.toml`
(stowed to `~/.config/herdr/`); plugins are declared in `ansible/config.yml`
(`herdr_plugin_list`) because herdr keeps no installable list of its own.

**Read `herdr/.config/herdr/MIGRATION.md` before changing any herdr config.** It records
the keybind map, what is deliberately impossible and why, and the traps below in more
detail — several cost multiple rounds to rediscover.

Validate every change with `herdr server reload-config && herdr config check`. A clean
reload is necessary but not sufficient:

- It does **not** validate `plugin_action` targets, so a wrong id fails silently. The
  separator is a dot (`plugin-id.action-id`), not a colon.
- A key collision is reported as `X: kept keys.foo, disabled keys.bar` rather than an
  error, and an unset built-in still holds its default key.
- `branch` and `git_status` are **built-ins herdr computes itself**; writing those token
  names via `report-metadata` is silently ignored. Custom metadata needs a `$` prefix
  (`$gitref`), and a token takes one `fg` for its whole value, so anything needing its
  own colour needs its own token.
- `tab_bar_right` command entries get **no shell** (pipes and `&&` arrive as literal
  argv — use a script) and render **no ANSI** (escapes print literally; upstream
  `herdrdev/herdr#3001`, fixed on preview).
- The keybinding parser rejects page keys, `home`/`end`/`insert`/`delete`, and multi-key
  chords. Ghostty translates those instead (see `ghostty/.config/ghostty/config`).

## Important Notes

- The system is designed for macOS (Darwin) environments only
- Requires sudo access for system-level changes
- Uses Poetry for Python dependency isolation
- Install script handles Homebrew installation automatically
- ASDF plugins and versions are centrally managed in `ansible/config.yml`
- The repository assumes the use of ghq for Git repository organization