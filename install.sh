#!/bin/bash

######################################################################
# ⚡SurrealTiggi/dotfiles - All-in-one install script                #
######################################################################
# Sets up Homebrew, downloads Brewfile, and bundles listed packages  #
######################################################################

# TODO: Add emojis to every INFO_COLOR

# Keyboard shortcuts:
# Find, Re-open, reload, new tab
# Apps:
# * Lightshot
# * Beardie
# * Neat.run

set -o errexit
set -o pipefail

# Global vars
PYTHON_VERSION=3.10.8
DOTFILES_REPO="github.com/SurrealTiggi/dotfiles" # NOTE: must match `dotfiles_repo` in ansible/config.yml
START_TIME=$(date +%s)                           # Start timer

# Colors
INFO_COLOR='\033[1;96m'
WARN_COLOR='\033[1;93m'
ERROR_COLOR='\033[1;31m'
RESET='\033[0m'

# Functions
echo_this() {
	local fmt="$1"
	shift

	# shellcheck disable=SC2059
	printf "\n$fmt\n" "$@"
}

# Adapted from https://raw.githubusercontent.com/Homebrew/install/master/install.sh
initial_checks() {
	# Check operating system
	OS="$(uname)"
	if [[ "${OS}" == "Darwin" ]]; then
		HOMEBREW_ON_MACOS=1
	else
		echo_this "${ERROR_COLOR}ERROR: This script only caters for MacOS homebrew installations!${RESET}"
		exit 1
	fi

	# Set homebrew directory accordingly
	if [[ -n "${HOMEBREW_ON_MACOS-}" ]]; then
		UNAME_MACHINE="$(/usr/bin/uname -m)"

		if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
			HOMEBREW_PREFIX="/opt/homebrew"
		else
			HOMEBREW_PREFIX="/usr/local"
		fi
	else
		UNAME_MACHINE="$(uname -m)"

		HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
	fi

	export PATH=${HOMEBREW_PREFIX}/bin:$PATH
}

set_vars() {
	echo_this "setting"
	export BECOME_PASS="surreal@con17T"        # TODO: Ask for this
	export WORK_GIT_ORG="github.com/conduktor" # TODO: Ask for this
}

install_xcode_cmdlines_utils() {
	if ! command -v cc >/dev/null; then
		echo_this "${INFO_COLOR}Installing xcode...{$RESET}"
		xcode-select --install
	else
		echo_this "${WARN_COLOR}Xcode already installed, skipping...${RESET}"
	fi
}

install_homebrew() {
	# TODO: Ensure curl exists
	if ! command -v brew >/dev/null; then
		echo_this "${INFO_COLOR}Installing Homebrew...{$RESET}"
		bash -c "$(NONINTERACTIVE=1 curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	else
		echo_this "${WARN_COLOR}Homebrew already installed, skipping...${RESET}"
	fi

}

update_brew() {
	echo_this "⤴️  ${INFO_COLOR}Updating packages${RESET}"
	brew update
	brew upgrade
}

# TODO: Need to curl or wget BREWFILE first
install_brew_apps() {
	echo_this "💾  ${INFO_COLOR}Installing listed apps...${RESET}"
	brew bundle --global --file "${BREWFILE}"
}

clone_dotfiles() {
	echo_this "${INFO_COLOR}Cloning dotfiles...${RESET}"
	if command -v ghq 2>/dev/null; then
		ghq get "${DOTFILES_REPO}" 2>/dev/null
	else
		echo_this "${ERROR_COLOR}ERROR: ghq missing!${RESET}"
		exit 1
	fi
}

setup_python() {
	echo_this "${INFO_COLOR}Setting up required dependencies...${RESET}"

	if ! command -v python >/dev/null; then
		if command -v asdf 2>/dev/null; then
			asdf plugin-add python
			asdf install python "${PYTHON_VERSION}"
		else
			echo_this "${ERROR_COLOR}ERROR: asdf missing!${RESET}"
			exit 1
		fi
	else
		echo_this "${WARN_COLOR}Python already installed, skipping...${RESET}"
	fi
}

# TODO: uncomment DOTFILES and remove --check
# TODO: supply sudo pass via an earlier var
run_ansible() {
	echo_this "${INFO_COLOR}Running ansible playbook...${RESET}"
	GHQ_ROOT=$(ghq root)
	export DOTFILES="${GHQ_ROOT}/${DOTFILES_REPO}"
	if command -v poetry 2>/dev/null; then
		# pushd "${DOTFILES}"
		poetry install
		poetry run ansible-galaxy install -r ansible/requirements.yml
		poetry run ansible-playbook ansible/playbook.yml --check --extra-vars="ansible_become_pass=${BECOME_PASS}" --tags terminal -i ansible/inventory
	else
		echo_this "${ERROR_COLOR}ERROR: poetry missing!${RESET}"
		exit 1
	fi
}

# Main
echo_this "⚡${INFO_COLOR}Boostrapping...${RESET}"

initial_checks
set_vars
install_xcode_cmdlines_utils
install_homebrew
# update_brew
# install_brew_apps
clone_dotfiles
setup_python
run_ansible

echo_this "✅ ${INFO_COLOR}Tasks completed successfully in $(($(date +%s) - START_TIME)) seconds${RESET}"
exit 0
