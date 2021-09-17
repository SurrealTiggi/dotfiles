#!/usr/bin/env bash

# A simple script to call easily cht.sh with some presets
# Thanks to ThePrimeagen

cheat_languages=(
  python
  golang
  nodejs
  javascript
  typescript
  lua
  bash
  css
  html
)
cheat_commands=(
  find
  sed
  awk
  tr
  xargs
  ag
  jq
  stow
)

selected=$(echo "${cheat_languages[@]}" "${cheat_commands[@]}" | tr ' ' '\n' | fzf)
if [[ -z $selected ]]; then
  exit 0
fi

read -rp "What do you need? " query


if printf '%s\n' "${cheat_languages[@]}" | grep -e "^${selected}$"; then
  query=$(echo "$query" | tr ' ' '+')
  tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
  tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
