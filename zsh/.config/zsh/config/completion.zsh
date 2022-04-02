# Kubernetes
## Default kubectl auto-completion
source <(kubectl completion zsh)
## Kubecolor auto-completion
compdef kubecolor=kubectl
## kns and kcx completion
complete -C kubens kubens
complete -C kubectx kubectx
## Helper to load individual kubeconfigs
source $HOME/.local/bin/load-k8s-configs.sh

# Azure
source $HOME/.local/etc/bash.completion.d/az.completion

# FluxCD
source <(flux completion zsh)

# Helm
source <(helm completion zsh)

# Kustomize
source <(kustomize completion zsh)
compdef _kustomize kustomize

# Github CLI
source <(gh completion -s zsh)
compdef _gh gh

# Poetry
if [ ! -f $ZSH_CUSTOM/plugins/poetry/_poetry ] && command -v poetry >/dev/null; then
  mkdir -p $ZSH_CUSTOM/plugins/poetry/
  poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
fi
