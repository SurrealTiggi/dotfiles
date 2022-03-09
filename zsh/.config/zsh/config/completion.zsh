## Kubernetes
# Default kubectl auto-completion
source <(kubectl completion zsh)
# Kubecolor auto-completion
compdef kubecolor=kubectl
# Helper to load individual kubeconfigs
source $HOME/.local/bin/load-k8s-configs.sh

## Azure
source $HOME/.local/etc/bash.completion.d/az.completion

## FluxCD
source <(flux completion zsh)

## Kustomize
source <(kustomize completion zsh)
