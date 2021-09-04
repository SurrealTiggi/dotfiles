# Enable if we ever need to troubleshoot, ditto for last line
# zmodload zsh/zprof

#-------------------------------
# DEFAULTS
#-------------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/tbaptista/.oh-my-zsh"

## Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

## Plugins
plugins=(
  git
  aws
  # kubectl
)

## Oh-my-zsh
# For a little extra speed, disables handle_completion_insecurities https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/compfix.zsh
export ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

#-------------------------------
# User configuration
#-------------------------------

## ZSH Vars
export ZSH_CONFIG="$HOME/.config/zsh/config"
# export ZSH_PLUGIN="$ZDOTDIR/plugins"
# export ZSH_CACHE="$HOME/.cache/zsh"

## Source config
[ -f $ZSH_CONFIG/exports.zsh ] && source $ZSH_CONFIG/exports.zsh
[ -f $ZSH_CONFIG/aliases.zsh ] && source $ZSH_CONFIG/aliases.zsh
[ -f $ZSH_CONFIG/options.zsh ] && source $ZSH_CONFIG/options.zsh
[ -f $ZSH_CONFIG/completion.zsh ] && source $ZSH_CONFIG/completion.zsh

## Extras
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Misc
# TODO: Look into a better way to do this as it causes overhead
# eval "$(direnv hook zsh)"

## Powerlevel10k
export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zprof
