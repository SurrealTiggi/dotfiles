# Aliases
## Dots
alias dots="cd $MY_GIT/personal/public/dotfiles"

## Handy map
alias map="cat $HOME/vgs.aws.md"
# alias ruby="$HOME/.rbenv/shims/ruby"
# alias gem="$HOME/.rbenv/shims/gem"
alias ls='colorls --sd -1'
alias ll='n -He -P p'
alias ctree='colorls --tree'
alias cat='bat'

## K8S
alias k='kubecolor'
alias kcx='kubectx'
alias kns='kubens'
alias kvu="k view-utilization -h"
alias kdebug="k run -i --tty --rm tiago-debug --image=surrealtiggi/kube-helper --image-pull-policy=Always --overrides='{\"spec\": {\"serviceAccountName\": \"default\"}}' -- /bin/sh"
alias kneat="kubectl neat | vim -c 'set ft=yaml' -"

## JQ
alias jqs='jless' # A nicer terminal json viewer https://github.com/PaulJuliusMartinez/jless
alias jqi='fx' # interactive JSON shell viewer (github.com/antonmedv/fx)

## Vim
alias vim='nvim'

## Git
alias gpl='git pull'
alias gt='git tag'

## GCP
alias gcp='gcloud'
alias gsp='gcloud config set project'
