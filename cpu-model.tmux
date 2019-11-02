#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/get_cpu_model.sh"

function main(){
  # fetching the value of "cpu-display" option
  local align="$(tmux show-option -gqv "@cpu-display")"

  local cpu_model_name="$(get_cpu_model)"
  if [[ "${align}" = "left" ]]; then
    tmux set -ag status-left "#[fg=colour232,bg=colour2,bold] ${cpu_model_name} "
  elif [[ "${align}" = "right" ]]; then
    tmux set -ag status-right "#[fg=colour232,bg=colour2,bold] ${cpu_model_name} "
  else
    cpu_model_name=""
  fi
}
main
