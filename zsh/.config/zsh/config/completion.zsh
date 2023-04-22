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

# FluxCD
source <(flux completion zsh)

# Helm
source <(helm completion zsh)

# Doppler
source <(doppler completion zsh)

# Kind
source <(kind completion zsh)
compdef _kind kind

# Kustomize
source <(kustomize completion zsh)
compdef _kustomize kustomize

# Github CLI
source <(gh completion -s zsh)
compdef _gh gh

# Gitlab CLI
source <(glab completion -s zsh)
compdef _glab glab

# Steampipe
source <(steampipe completion zsh)
compdef _steampipe steampipe

# Azure
source $HOME/.local/etc/bash.completion.d/az.completion

# Poetry
if [ ! -f $ZSH_CUSTOM/plugins/poetry/_poetry ] && command -v poetry >/dev/null; then
  mkdir -p $ZSH_CUSTOM/plugins/poetry/
  poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
fi

# Vault
complete -o nospace -C /opt/homebrew/bin/vault vault
