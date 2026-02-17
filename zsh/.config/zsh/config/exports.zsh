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

## GPG
export GPG_TTY=$TTY

## K8S
export KUBE_EDITOR=nvim

## Docker
export DOCKER_HOST=""

## FZF | Ctrl+T
# export FZF_DEFAULT_COMMAND="rg --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,.git/*,go.sum,package-lock.json,**/.terraform/*}'"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git --exclude node_modules --exclude go.sum --exclude package-lock.json --exclude '**/.terraform/*'"
export FZF_DEFAULT_OPTS="--no-mouse --height 30% -1 --reverse --multi --inline-info --preview='bat --color=always --style=numbers --line-range=:500 {}'"

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

# Preview settings for preview-tui plugin
export NNN_SCOPE=1                  # Enable scope.sh for enhanced file previewing
export NNN_SPLIT='h'                # Split direction: 'h' = right vertical, 'v' = lower horizontal (tmux inverts this)
export NNN_SPLITSIZE=50             # Preview pane size percentage (default: 50)
export NNN_PAGER='less -R'          # Pager for preview scrolling
export NNN_BATTHEME='Nord'          # Bat theme for syntax highlighting (matches BAT_THEME)
export NNN_BATSTYLE='numbers,grid'  # Bat style: show line numbers and grid

## AWS
export AWS_PAGER=""

## SOPS
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt

# Path stuff
# Cache HOMEBREW_PREFIX to avoid slow brew --prefix calls on every shell startup
HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"
export PATH="${HOMEBREW_PREFIX}/opt/bash/bin:$PATH"
export PATH="${HOMEBREW_PREFIX}/opt/awscli/bin:$PATH"
export PATH="${HOMEBREW_PREFIX}/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
export PATH=./node_modules/.bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/13/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.vector/bin:$PATH"
