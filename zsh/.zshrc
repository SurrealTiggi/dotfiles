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
export ZSH="$HOME/.oh-my-zsh"

## Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

## Plugins
plugins=(
  git
  aws
  asdf
  brew
  gcloud
  git-extras
  kubectl
  poetry
  uv
  web-search
  yarn
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

## Oh-my-zsh
# For a little extra speed, disables handle_completion_insecurities https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/compfix.zsh
export ZSH_DISABLE_COMPFIX=true

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

#-------------------------------
# User configuration
#-------------------------------

## ZSH Vars
export ZSH_CONFIG="$HOME/.config/zsh/config"
export ZSH_THEMES="$HOME/.config/zsh/themes"
# export ZSH_PLUGIN="$ZDOTDIR/plugins"
# export ZSH_CACHE="$HOME/.cache/zsh"

## Source config
[ -f $ZSH_CONFIG/exports.zsh ] && source $ZSH_CONFIG/exports.zsh
[ -f $ZSH_CONFIG/aliases.zsh ] && source $ZSH_CONFIG/aliases.zsh
[ -f $ZSH_CONFIG/options.zsh ] && source $ZSH_CONFIG/options.zsh
[ -f $ZSH_CONFIG/completion.zsh ] && source $ZSH_CONFIG/completion.zsh
[ -f $ZSH_CONFIG/functions.zsh ] && source $ZSH_CONFIG/functions.zsh

## Powerlevel overrides
[[ ! -f $ZSH_THEMES/p10k.zsh ]] || source $ZSH_THEMES/p10k.zsh

## Extras
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Herdr rename
for _f in ${HOME}/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.zsh(N); do
  source $_f; break
done

## Misc
# direnv: Uncomment if needed, but causes shell startup overhead (~100-200ms)
# eval "$(direnv hook zsh)"

# zprof

export PATH="$HOME/.local/bin:$PATH"

# Google Workspace CLI credentials (added by so gws init)
export GOOGLE_WORKSPACE_CLI_CREDENTIALS_FILE="/Users/tiago.baptista/.config/gws/credentials.json"
