#!/bin/bash

###########################################################################
# A script to set basic MacOS settings                                    #
#                                                                         #
# Inspired by:                                                            #
# https://github.com/siyelo/laptop/blob/master/scripts/system_settings.sh #
###########################################################################

# See TODO.md for all outstanding tasks

set -o errexit
set -o pipefail

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

echo_this " -------------------- Applying macOS settings... -----------------------"

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1

# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# No font smoothing
defaults -currentHost write -g AppleFontSmoothing -int 0

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Display full POSIX path as Finder window title
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Dock
defaults write com.apple.dock magnification -boolean true
defaults write com.apple.dock tilesize -integer 30
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock largesize -integer 128
defaults write com.apple.dock mru-spaces -bool "false"
killall Dock # restart

# defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
# defaults write com.apple.LaunchServices LSQuarantine -bool false
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# defaults write NSGlobalDomain KeyRepeat -int 1
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# defaults write NSGlobalDomain _HIHideMenuBar -bool true
# defaults write NSGlobalDomain AppleHighlightColor -string "0.65098 0.85490 0.58431"
# defaults write NSGlobalDomain AppleAccentColor -int 1
# defaults write com.apple.screencapture location -string "$HOME/Desktop"
# defaults write com.apple.screencapture disable-shadow -bool true
# defaults write com.apple.screencapture type -string "png"
# defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.Finder AppleShowAllFiles -bool true
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathBar -bool true
defaults write com.apple.finder ShowSideBar -bool true
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
# defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
