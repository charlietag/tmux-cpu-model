#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"


main() {
  local cpu_model_colour_dark_mode="off" # default: off
  cpu_model_colour_dark_mode="$(tmux show-option -gqv "@cpu-model-colour-dark-mode")"

  local cpu_model_dark_enabled="$1"
  if [[ "${cpu_model_dark_enabled}" = "dark-on" ]]; then
    cpu_model_colour_dark_mode="on"
  elif [[ "${cpu_model_dark_enabled}" = "dark-off" ]]; then
    cpu_model_colour_dark_mode="off"
  fi


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

  if [[ "${cpu_model_colour_dark_mode}" = "off" ]]; then
    local cpu_colour="$(tmux show-option -gqv "@cpu-model-colour")"
    [[ -z "${cpu_colour}" ]] && cpu_colour="fg=colour232,bg=colour2,bold"
  else
    local cpu_colour="$(tmux show-option -gqv "@cpu-model-colour-dark")"
    [[ -z "${cpu_colour}" ]] && cpu_colour="fg=colour2,bg=black,bold"
  fi

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


  # --- For support tmux-split-statusbar ---
  local cpu_model_colour_last="$(tmux show-option -gqv "@cpu-model-colour-last")"
  local cpu_model_no_reload="$2"
  if [[ "${cpu_model_no_reload}" != "no-reload" ]]; then
    if [[ -n "${cpu_model_colour_last}" ]]; then
      if [[ "${cpu_model_colour_last}" != "${cpu_colour}" ]]; then
        #----- reload tmux-split-statusbar ---
        local check_plugin_status="$(cat ~/.tmux.conf |awk '/^[ \t]*set(-option)? +-g +@plugin/ { gsub(/'\''/,""); gsub(/'\"'/,""); print $4 }' | grep 'charlietag/tmux-split-statusbar')"

        if [[ -n "${check_plugin_status}" ]]; then
          local plugin_script="$(readlink -m ~/.tmux/plugins/tmux-split-statusbar/tmux-split-statusbar.tmux)"
          if [[ -f "${plugin_script}" ]]; then
            ${plugin_script} reload
          fi
        fi
        #----- reload tmux-split-statusbar ---
      fi
    fi
  fi
  tmux set -g @cpu-model-colour-last ${cpu_colour}
  # --- For support tmux-split-statusbar ---




}
main "$1" "$2"
