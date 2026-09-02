# Aliases
## Dots
alias dots="cd $MY_GIT/dotfiles"

## Handy map
alias map="cat $HOME/vgs.aws.md"
# alias ruby="$HOME/.rbenv/shims/ruby"
# alias gem="$HOME/.rbenv/shims/gem"
# alias ls='colorls --sd -1'
alias ls='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first'
alias lsa='eza --color=always --long --git --icons=always --no-user --group-directories-first'
# alias ll='n -He -P p'
alias ll='yazi'
alias ctree='colorls --tree'
alias cat='bat'

# Dig ignore ipv6
alias dig='dig -4 +noall +answer'

## K8S
# alias kubectl='kubecolor'
alias k='kubecolor'
alias kcx='kubectx'
alias kns='kubens'
alias kvu="k view-utilization -h"
alias kdebug="k run -i --tty --rm tiago-debug --image=surrealtiggi/kube-helper --image-pull-policy=Always --overrides='{\"spec\": {\"serviceAccountName\": \"default\"}}' -- /bin/sh"
alias ksql="k run -i --tty --rm tiago-debug --image=postgres --image-pull-policy=Always --overrides='{"spec": {"serviceAccountName": "default"}}' -- /bin/sh"
alias kneat="$(brew --prefix)/bin/kubectl neat | vim -c 'set ft=yaml' -"
alias kgetall="k api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --no-headers --show-kind --ignore-not-found"
alias king="k ingress-nginx-cm"
alias kb="kustomize build --enable-alpha-plugins --enable-exec --enable-helm"

## ArgoCD
alias acd='argocd'
# Work-specific contexts live in aliases.work.zsh (gitignored: internal
# hostnames, and this repo is public). See aliases.work.zsh.example.
[ -f "$ZSH_CONFIG/aliases.work.zsh" ] && source "$ZSH_CONFIG/aliases.work.zsh"

## JQ
alias jqs='jless' # A nicer terminal json viewer https://github.com/PaulJuliusMartinez/jless
alias jqi='fx' # interactive JSON shell viewer (github.com/antonmedv/fx)

## Vim
alias vim='nvim'

## Git
alias gpl='git pull'
alias gt='git tag'
alias gs='git-spice'

## GCP
alias gcp='gcloud'
alias cfg='config-connector'

## PSQL
alias psql='pgcli'

## GNU sed
alias sed='gsed'

## Claude
# alias cl='claude --append-system-prompt "$(~/.claude/task-enforcement.sh)"'
alias cl='~/.claude/cl-wrapper.sh'
