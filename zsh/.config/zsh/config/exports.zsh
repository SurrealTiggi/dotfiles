# General exports
## Editor
export EDITOR="nvim"

## Tmux
[[ -n $TMUX ]] || export TERM="xterm-256color"

## Main Git dir
export MY_GIT="$HOME/git"

## Golang
export GOPATH="$HOME/go"
#export GOARCH="amd64"
#export GOOS="linux"
export CGO_ENABLED=1

## Pyenv
# TODO: Is pyenv still required with asdf?
# FIXME: Commenting out as it's slow to start
export PYENV_ROOT="$HOME/.pyenv"
# if which pyenv > /dev/null; then eval "$(pyenv init -)" > /dev/null; fi

## Docker remote
export DOCKER_HOST=tcp://ornstein.cm.local:2375

## GPG
export GPG_TTY=$TTY

## K8S
export KUBE_EDITOR=nvim

## FZF | Ctrl+T
export FZF_DEFAULT_COMMAND="rg --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,.git/*,go.sum,package-lock.json,**/.terraform/*}'"
export FZF_DEFAULT_OPTS="--no-mouse --height 30% -1 --reverse --multi --inline-info"

## Sensitive vars
[ -f $ZSH_CONFIG/.env.secret ] && source $ZSH_CONFIG/.env.secret

## Github CLI
export GH_PAGER=""  # Disables pager

## Bat
export BAT_THEME=Nord

## NNN
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='d:diffs;p:preview-tui'
# export NNN_FCOLORS='0000E6310000000000000000'

## AWS
export AWS_PAGER=""

# Path stuff
# Putting aws v2 first to override pyenv shim
export PATH="$(brew --prefix awscli)/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH=./node_modules/.bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/13/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# export PATH="$HOME/.poetry/bin:$PATH"
