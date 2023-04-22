## Custom Powerlevel10k settings
# load p10k itself
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## 24bit colors
local color_red=1
local color_yellow=3
local color_green=2
local color_light_green=41
local color_white=7
local color_blue=33
local color_light_blue=39
local color_dark_blue=27
local color_purple=135
local color_orange=172
local color_dark_red=168

## Prompt elements + overrides https://github.com/romkatv/powerlevel10k#batteries-included
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon
  dir
  vcs
  prompt_char
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status
  background_jobs
  asdf
  virtualenv
  kubecontext
  aws
  gcloud
)

typeset -g POWERLEVEL9K_MODE=nerdfont-complete
typeset -g POWERLEVEL9K_ICON_PADDING=moderate

#################################[ os_icon: os identifier ]##################################
# typeset -g POWERLEVEL9K_APPLE_ICON='\uf5a6 ' # hazard
typeset -g POWERLEVEL9K_APPLE_ICON='\ufb8a ' # skull

################################[ prompt_char: prompt symbol ]################################
local my_ok_prompt="%{$fg_bold[red]%}❱%{$fg_bold[yellow]%}❱%{$fg_bold[green]%}❱"
local my_error_prompt="%{$fg_bold[red]%}❱❱❱"

typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION=$my_ok_prompt
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_CONTENT_EXPANSION=$my_error_prompt

##################################[ dir: current directory ]##################################
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=20

#####################################[ vcs: git status ]######################################
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON="\uf126 "

###############[ asdf: asdf version manager (https://github.com/asdf-vm/asdf) ]###############
# NOTE: show prompt even if the local version matches `asdf global <tool> <version>`
typeset -g POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=true

# Python version from asdf
typeset -g POWERLEVEL9K_ASDF_PYTHON_FOREGROUND=$color_light_blue
typeset -g POWERLEVEL9K_ASDF_PYTHON_VISUAL_IDENTIFIER_EXPANSION=' '
typeset -g POWERLEVEL9K_ASDF_PYTHON_SHOW_ON_UPGLOB='setup.py|setup.cfg|pyproject.toml|Pipfile'

# Golang version from asdf
typeset -g POWERLEVEL9K_ASDF_GOLANG_FOREGROUND=$color_blue
typeset -g POWERLEVEL9K_ASDF_GOLANG_VISUAL_IDENTIFIER_EXPANSION='ﳑ '
typeset -g POWERLEVEL9K_ASDF_GOLANG_SHOW_ON_UPGLOB='go.sum|go.mod'

# Javascript version from asdf
typeset -g POWERLEVEL9K_ASDF_NODEJS_FOREGROUND=$color_light_green
typeset -g POWERLEVEL9K_ASDF_NODEJS_VISUAL_IDENTIFIER_EXPANSION=' '
typeset -g POWERLEVEL9K_ASDF_NODEJS_SHOW_ON_UPGLOB='package.json'

# Ruby version from asdf
typeset -g POWERLEVEL9K_ASDF_RUBY_FOREGROUND=$color_dark_red
typeset -g POWERLEVEL9K_ASDF_RUBY_VISUAL_IDENTIFIER_EXPANSION=' '
typeset -g POWERLEVEL9K_ASDF_RUBY_SHOW_ON_UPGLOB='*.rb'

# Rust version from asdf
typeset -g POWERLEVEL9K_ASDF_RUST_FOREGROUND=$color_orange
typeset -g POWERLEVEL9K_ASDF_RUST_VISUAL_IDENTIFIER_EXPANSION=' '
typeset -g POWERLEVEL9K_ASDF_RUST_SHOW_ON_UPGLOB='*.rs|Cargo.toml'

# Terraform version from asdf
typeset -g POWERLEVEL9K_ASDF_TERRAFORM_FOREGROUND=$color_purple
typeset -g POWERLEVEL9K_ASDF_TERRAFORM_VISUAL_IDENTIFIER_EXPANSION=' '
typeset -g POWERLEVEL9K_ASDF_TERRAFORM_SHOW_ON_UPGLOB='*.tf|*.hcl'

# Disable other annoying versions
# NOTE: not sure if there's a better way to do this?
typeset -g POWERLEVEL9K_ASDF_POETRY_SHOW_ON_UPGLOB='DISABLED'
typeset -g POWERLEVEL9K_ASDF_AWSCLI_SHOW_ON_UPGLOB='DISABLED'
typeset -g POWERLEVEL9K_ASDF_PACKER_SHOW_ON_UPGLOB='DISABLED'
typeset -g POWERLEVEL9K_ASDF_GCLOUD_SHOW_ON_UPGLOB='DISABLED'
typeset -g POWERLEVEL9K_ASDF_TANKA_SHOW_ON_UPGLOB='DISABLED'
typeset -g POWERLEVEL9K_ASDF_JB_SHOW_ON_UPGLOB='DISABLED'
typeset -g POWERLEVEL9K_ASDF_JSONNET_SHOW_ON_UPGLOB='DISABLED'


#########################[ virtualenv: python virtual environment ]###########################
typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false
typeset -g POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_EXPANSION=' '

################[ pyenv: python environment (https://github.com/pyenv/pyenv) ]################
typeset -g POWERLEVEL9K_PYENV_VISUAL_IDENTIFIER_EXPANSION=''

##########################[ kubecontext: current kubernetes context ]#########################
typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubecolor|kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern|k|kns|kcx'
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=$color_purple

#####################################[ aws: aws profile ]#####################################
# unset POWERLEVEL9K_AWS_SHOW_ON_COMMAND # Always show in case of terraform commands
typeset -g POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|awless|terraform|pulumi|terragrunt|tf|tg|aws-profile|asp'

typeset -g POWERLEVEL9K_AWS_CLASSES=(
  # '*prod*'  PROD    # These values are examples that are unlikely
  # '*test*'  TEST    # to match your needs. Customize them as needed.
  '*'       DEFAULT)
typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=$color_orange

## Transient prompt
# typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

#####################################[ gcloud: GCP profile ]##################################
typeset -g POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcp'
typeset -g POWERLEVEL9K_GCLOUD_VISUAL_IDENTIFIER_EXPANSION=' '
typeset -g POWERLEVEL9K_GCLOUD_FOREGROUND=$color_light_blue
