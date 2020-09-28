# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/tbaptista/.oh-my-zsh"

# Tmux fix
export TERM=xterm-256color

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'
neofetch

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	kubectl
  aws
  virtualenv
)

source $ZSH/oh-my-zsh.sh
source /usr/local/bin/aws_zsh_completer.sh
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

#Exports
export JAVA_HOME=$(/usr/libexec/java_home)
export NVM_DIR="/home/tbaptista/.nvm"

# GO exports
export GOPATH=$HOME/go
#export GOARCH="amd64"
#export GOOS="linux"
export CGO_ENABLED=1

# PATH
export PATH=$PATH:/usr/local/Cellar/mtr/0.92/sbin/:$GOPATH/bin:$HOME/node_modules/.bin:$HOME/.cargo/bin

# Aliases
alias python='python3'
alias pip='pip3'
alias ipy='ptipython'
alias ll='colorls --sd'
alias ls='colorls --sd -1'

## Openstack
alias oscix='source ~/.cloudcreds/openstackrc_test.sh'
#alias openstack='~/.cloudcreds/dockerwrapper.sh'

## K8S
alias k='kubectl'
alias kcx='kubectx'
alias kcxd='kubectx docker-for-desktop'
alias kns='kubens'
alias kdebug='k run --generator=run-pod/v1 -it tiago-debug --rm --image=surrealtiggi/kube-helper --image-pull-policy=Always /bin/sh'

## JQ
alias jqs='jid' # jq compatible shell (github.com/simeji/jid)
alias jqi='fx' # interactive JSON shell viewer (github.com/antonmedv/fx)

## Vim
alias vim='nvim'

## Vault
export VAULT_ADDR=https://vault.poppulo-tooling.com
#export VAULT_PWD=]_i&dRNR7^//E_h4_Qei$@55X:X[Z*dt~*r]$&LP@b3Y:{CuMo

## FZF
export FZF_DEFAULT_OPTS="--no-mouse --height 30% -1 --reverse --multi --inline-info"

# PL9K
## General
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="❱ "

## Context
POWERLEVEL9K_CONTEXT_TEMPLATE='%n'
#POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='white'

## Battery
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_BATTERY_ICON='\uf1e6 '

## VCS
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='orange'
POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

## K8S
zsh_custom_kube_ps1(){
  echo -n "$(_kube_ps1_symbol)$KUBE_PS1_SEPERATOR$KUBE_PS1_CONTEXT$KUBE_PS1_DIVIDER$KUBE_PS1_NAMESPACE" | sed -e 's/\%//'
}
POWERLEVEL9K_CUSTOM_KUBE_PS1='zsh_custom_kube_ps1'

## Left/Right prompts
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context battery dir kube-ps1 vcs)
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context battery dir vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status ip background_jobs time)


## Time
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_TIME_BACKGROUND='white'
#POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="white"
#POWERLEVEL9K_LOAD_WARNING_BACKGROUND="white"
#POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="white"
#POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="red"
#POWERLEVEL9K_LOAD_WARNING_FOREGROUND="yellow"
#POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="black"
#POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
#POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
#POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"
#POWERLEVEL9K_HOME_ICON=''
#POWERLEVEL9K_HOME_SUB_ICON=''
#POWERLEVEL9K_FOLDER_ICON=''
#
function kt() {
  if (( ${+POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND} )); then
    unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND
  else
    POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|k'
  fi
  p10k reload
  if zle; then
    zle push-input
    zle accept-line
  fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
