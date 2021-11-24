## Aliases
# Dots
alias dots="cd $MY_GIT/personal/public/dotfiles"

# Handy map
alias map="cat $HOME/vgs.aws.md"
# alias ruby="$HOME/.rbenv/shims/ruby"
# alias gem="$HOME/.rbenv/shims/gem"
alias ll='colorls --sd'
alias ls='colorls --sd -1'
alias tree='colorls --tree'
alias cat='bat'

## K8S
alias k='kubecolor'
alias kcx='kubectx'
alias kns='kubens'
alias kvu="k view-utilization -h"
alias kdebug='k run --generator=run-pod/v1 -it tiago-debug --rm --image=surrealtiggi/kube-helper --image-pull-policy=Always /bin/sh'

## JQ
alias jqs='jiq' # jq compatible shell (github.com/fiatjaf/jiq)
alias jqi='fx' # interactive JSON shell viewer (github.com/antonmedv/fx)

## Vim
alias vim='nvim'

## Git
alias gpl='git pull'
alias gt='git tag'

## GCP
alias gcp='gcloud'
alias gsp='gcloud config set project'
