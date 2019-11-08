#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/get_cpu_model.sh"

function main(){
  # fetching the value of "cpu-model-*" var
  local align="$(tmux show-option -gqv "@cpu-model-mode")"
  local cpu_colour="$(tmux show-option -gqv "@cpu-model-colour")"
  [[ -z "${cpu_colour}" ]] && cpu_colour="fg=colour232,bg=colour2,bold"

  local cpu_model_name="$(get_cpu_model)"
  if [[ "${align}" = "left" ]]; then
    tmux set -ag status-left "#[${cpu_colour}] ${cpu_model_name} "
  elif [[ "${align}" = "right" ]]; then
    tmux set -ag status-right "#[${cpu_colour}] ${cpu_model_name} "
  else
    cpu_model_name=""
  fi
}
main
