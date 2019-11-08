#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"


main() {
  # Backup default status char length for both status-right , status-left
  set_default_length
  # Set default length
  local default_status_left_length="$(tmux show-option -gqv "@default-status-left-length")"
  local default_status_right_length="$(tmux show-option -gqv "@default-status-right-length")"

  # Set new length
  local new_status_left_length="$(( ${default_status_left_length} + 40))"
  local new_status_right_length="$(( ${default_status_right_length} + 40))"

  # fetching the value of "cpu-model-*" var
  local cpu_model_name="$(get_cpu_model)"

  # Setup options from .tmux.conf
  local align="$(tmux show-option -gqv "@cpu-model-mode")"
  local cpu_colour="$(tmux show-option -gqv "@cpu-model-colour")"
  [[ -z "${cpu_colour}" ]] && cpu_colour="fg=colour232,bg=colour2,bold"


  # Start to apply tmux-cpu-model plugin
  if [[ "${align}" = "left" ]]; then
    tmux set -g status-left-length ${new_status_left_length}
    tmux set -g status-right-length ${default_status_right_length}

    tmux set -ag status-left "#[${cpu_colour}] ${cpu_model_name} "

  elif [[ "${align}" = "right" ]]; then
    tmux set -g status-left-length ${default_status_left_length}
    tmux set -g status-right-length ${new_status_right_length}

    tmux set -ag status-right "#[${cpu_colour}] ${cpu_model_name} "

  else
    cpu_model_name=""
    tmux set -g status-left-length ${default_status_left_length}
    tmux set -g status-right-length ${default_status_right_length}
  fi
}
main
