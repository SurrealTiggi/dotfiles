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

# 1Password
source <(op completion zsh)

# FluxCD
source <(flux completion zsh)

# ArgoCD
source <(argo completion zsh)
source <(argocd completion zsh)

# Helm
source <(helm completion zsh)

# Doppler
source <(doppler completion zsh)

# Docker
source <(docker completion zsh)

# Kind
source <(kind completion zsh)
compdef _kind kind

# K3D
source <(k3d completion zsh)
compdef _k3d k3d

# Kustomize
source <(kustomize completion zsh)
compdef _kustomize kustomize

# Github CLI
source <(gh completion -s zsh)
compdef _gh gh


# Gitlab CLI
# source <(glab completion -s zsh)
# compdef _glab glab

# Steampipe
# source <(steampipe completion zsh)
# compdef _steampipe steampipe

# Velero
# source <(velero completion zsh)
# compdef _velero velero

# Poetry
if [ ! -f $ZSH_CUSTOM/plugins/poetry/_poetry ] && command -v poetry >/dev/null; then
  mkdir -p $ZSH_CUSTOM/plugins/poetry/
  poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
fi

# Vault
# complete -o nospace -C /opt/homebrew/bin/vault vault

# Sanity
source ${HOME}/ghq/github.com/sanity-io/so/completion/completion.bash.inc

# Terraform
# autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/tiago.baptista/.asdf/installs/terraform/1.12.2/bin/terraform terraform
