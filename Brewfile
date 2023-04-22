{{/* vim: set filetype=ruby: */}}
###################################################################
# ~/.Brewfile - Minimal Software Installs for MacOS               #
#                                                                 #
# Minimum list of packages to be installed / updated via Homebrew #
# Remaining apps are managed via ansible in the source GH repo    #
###################################################################
# Usage, run: $ brew bundle --global --file $HOME/.Brewfile       #
# Source GH repository: https://github.com/SurrealTiggi/dotfiles  #
# See brew docs for more info: https://docs.brew.sh/Manpage       #
###################################################################
# License: MIT © Tiago Baptista 2022                              #
###################################################################

# Options
#########
cask_args appdir: '~/Applications', require_sha: true

# Taps
######
tap 'homebrew/bundle'
tap 'homebrew/core'
tap 'homebrew/services'

# Packages
##########
# This is a minimal list of packages required to bootstrap an ansible
# virtualenv via poetry that performs and manages things going forward.

brew 'asdf'           # Extendable version manager for *all the things*
brew 'ghq'            # Git repo manager
brew 'poetry'         # Required to install ansible
brew 'neovim' --HEAD  # Neovim
