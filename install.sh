#!/bin/bash

######################################################################
# ⚡SurrealTiggi/dotfiles - All-in-one install script                #
######################################################################
# Sets up Homebrew, downloads Brewfile, and bundles listed packages  #
######################################################################

set -o errexit
set -o pipefail

# Global vars
PYTHON_VERSION=3.11.0
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

set_pass() {
	# Credit: https://antofthy.gitlab.io/software/askpass_stars_v1.sh.txt
	unset password
	password=

	echo -n 'Sudo password: ' 1>&2

	while IFS= read -r -n1 -s char; do
		code=${char:+$(printf '%02x' "'$char'")}

		case "$code" in
		'' | 0a | 0d) break ;;
		08 | 7f)
			if [ -n "$password" ]; then
				password="$(echo "$password" | sed 's/.$//')"
				echo -n $'\b \b' 1>&2
			fi
			;;
		15)
			echo -n "$password" | sed 's/./\cH \cH/g' >&2
			password=''
			;;
		[01]?) ;;
		*)
			password+="$char"
			echo -n '*' 1>&2
			;;
		esac
	done
	echo

	sudo -k
	if ! echo $password | sudo -lS &>/dev/null; then
		echo_this "Wrong password."
		exit 1
	fi

	# read -rp "Work git organisation (eg. github.com/example): " WORK_GIT_ORG

	export BECOME_PASS="$password"
	# export WORK_GIT_ORG="bar"
}

install_xcode_cmdlines_utils() {
	if ! command -v cc >/dev/null; then
		echo_this "🔧  ${INFO_COLOR}Installing xcode...${RESET}"
		xcode-select --install
	else
		echo_this "${WARN_COLOR}Xcode already installed, skipping...${RESET}"
	fi
}

install_homebrew() {
	if ! command -v curl >/dev/null; then
		echo_this "${ERROR_COLOR}ERROR: curl is required but not found!${RESET}"
		exit 1
	fi

	if ! command -v brew >/dev/null; then
		echo_this "🍺  ${INFO_COLOR}Installing Homebrew...${RESET}"
		bash -c "$(NONINTERACTIVE=1 curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		# Ensure brew is in PATH for the rest of the script
		if [[ -x "${HOMEBREW_PREFIX}/bin/brew" ]]; then
			eval "$("${HOMEBREW_PREFIX}/bin/brew" shellenv)"
		fi
	else
		echo_this "${WARN_COLOR}Homebrew already installed, skipping...${RESET}"
	fi
	brew analytics off
}

update_brew() {
	echo_this "⤴️  ${INFO_COLOR}Updating packages${RESET}"
	brew update
	brew upgrade
}

download_brewfile() {
	echo_this "📥  ${INFO_COLOR}Downloading Brewfile...${RESET}"

	if [ -f "Brewfile" ]; then
		echo_this "${WARN_COLOR}Brewfile already exists, skipping download...${RESET}"
		return
	fi

	BREWFILE_URL="https://raw.githubusercontent.com/${DOTFILES_REPO}/main/Brewfile"
	if ! curl -fsSL "$BREWFILE_URL" -o Brewfile; then
		echo_this "${ERROR_COLOR}ERROR: Failed to download Brewfile from $BREWFILE_URL${RESET}"
		exit 1
	fi
}

install_brew_apps() {
	echo_this "💾  ${INFO_COLOR}Installing listed apps...${RESET}"
	brew bundle --file Brewfile

	# Ensure newly installed binaries are in PATH
	hash -r
}

clone_dotfiles() {
	echo_this "📦  ${INFO_COLOR}Cloning dotfiles...${RESET}"
	DOTFILES_DIR="$HOME/dotfiles"

	if [ -d "$DOTFILES_DIR" ]; then
		echo_this "${WARN_COLOR}Dotfiles directory already exists at $DOTFILES_DIR, skipping...${RESET}"
	else
		if ! command -v git >/dev/null; then
			echo_this "${ERROR_COLOR}ERROR: git is required but not found!${RESET}"
			exit 1
		fi
		git clone "https://${DOTFILES_REPO}" "$DOTFILES_DIR"
	fi
}

setup_python() {
	echo_this "🐍  ${INFO_COLOR}Installing Python and Ansible via uv...${RESET}"

	if ! command -v uv >/dev/null; then
		echo_this "${ERROR_COLOR}ERROR: uv missing!${RESET}"
		exit 1
	fi

	# uv will handle Python installation automatically
	uv pip install --system ansible
}

run_ansible() {
	echo_this "🤖  ${INFO_COLOR}Running ansible playbook...${RESET}"
	export DOTFILES="$HOME/dotfiles"

	if [ ! -d "$DOTFILES" ]; then
		echo_this "${ERROR_COLOR}ERROR: Dotfiles directory not found at $DOTFILES${RESET}"
		exit 1
	fi

	if ! command -v ansible-playbook >/dev/null; then
		echo_this "${ERROR_COLOR}ERROR: ansible not installed!${RESET}"
		exit 1
	fi

	cd "$DOTFILES"
	ansible-galaxy collection install geerlingguy.mac
	ansible-playbook ansible/playbook.yml --extra-vars="ansible_become_pass=${BECOME_PASS}" -i ansible/inventory --tags asdf
}

# Main
echo_this " --------------------------- INIT --------------------------- "
echo_this "⚡${INFO_COLOR}Boostrapping...${RESET}"

initial_checks
set_pass
install_xcode_cmdlines_utils
install_homebrew
update_brew
download_brewfile
install_brew_apps
clone_dotfiles
setup_python
run_ansible

echo_this "✅ ${INFO_COLOR}Tasks completed successfully in $(($(date +%s) - START_TIME)) seconds${RESET}"
echo_this " --------------------------- DONE --------------------------- "
exit 0
