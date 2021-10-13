# Default kubectl auto-completion
source <(kubectl completion zsh)
# Kubecolor auto-completion
complete -o default -F __start_kubectl kubecolor
