#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"


main() {
  # Backup default status char length for both status-right , status-left
  set_default_length
  # Set default length
  local default_status_left_length="$(tmux show-option -gqv "@default-status-left-length")"
  local default_status_right_length="$(tmux show-option -gqv "@default-status-right-length")"

  # fetching the value of "cpu-model-*" var
  local cpu_model_name="$(get_cpu_model)"
  local cpu_model_name_length="$(echo "4 + ${#cpu_model_name}" | bc)"

  # Set new length
  local new_status_left_length="$(( ${default_status_left_length} + ${cpu_model_name_length}))"
  local new_status_right_length="$(( ${default_status_right_length} + ${cpu_model_name_length}))"

  # Setup options from .tmux.conf
  local align="$(tmux show-option -gqv "@cpu-model-mode")"
  local cpu_colour="$(tmux show-option -gqv "@cpu-model-colour")"
  [[ -z "${cpu_colour}" ]] && cpu_colour="fg=colour232,bg=colour2,bold"

  local cpu_model_mode_pre="$(tmux show-option -gqv "@cpu-model-mode-pre")"
  local cpu_model_exists="$(tmux show-option -gqv "status-left"| grep -i cpu | grep -vE "^@" ; tmux show-option -gqv "status-right"| grep -i cpu | grep -vE "^@" )"



  # Start to apply tmux-cpu-model plugin
  if [[ "${align}" = "left" ]]; then
    if [[ "${cpu_model_mode_pre}" != "left" ]] || [[ -z "${cpu_model_exists}" ]]; then
      tmux set -g status-left-length ${new_status_left_length}
      tmux set -g status-right-length ${default_status_right_length}

      tmux set -ag status-left "#[${cpu_colour}] ${cpu_model_name} "
    fi

  elif [[ "${align}" = "right" ]]; then
    if [[ "${cpu_model_mode_pre}" != "right" ]] || [[ -z "${cpu_model_exists}" ]]; then
      tmux set -g status-left-length ${default_status_left_length}
      tmux set -g status-right-length ${new_status_right_length}

      tmux set -ag status-right "#[${cpu_colour}] ${cpu_model_name} "
    fi

  else
    if [[ "${cpu_model_mode_pre}" = "left" ]] || [[ "${cpu_model_mode_pre}" = "right" ]] ; then
      cpu_model_name=""
      tmux set -g status-left-length ${default_status_left_length}
      tmux set -g status-right-length ${default_status_right_length}
    fi
  fi
  tmux set -g @cpu-model-mode-pre ${align}
}
main
