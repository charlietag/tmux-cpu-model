set_default_length() {
  local default_status_left_length="$(tmux show-option -gqv "@default-status-left-length")"
  #local default_status_right_length="$(tmux show-option -gqv "@default-status-right-length")"

  if [[ -z "${default_status_left_length}" ]]; then
    local default_status_left_length="$(tmux show-option -gqv "status-left-length")"
    local default_status_right_length="$(tmux show-option -gqv "status-right-length")"
    tmux set -g @default-status-left-length ${default_status_left_length}
    tmux set -g @default-status-right-length ${default_status_right_length}
  fi
}

get_cpu_model() {
  #local this_cpu_name="$(cat /proc/cpuinfo | grep 'model name' | grep -Eo 'CPU[[:print:]]+@ [[:digit:]|.]+GHz' | head -1)"
  local this_cpu_info="$(tmux show-option -gqv "@cpu-model-info")"

  local this_cpu_name="$(cat /proc/cpuinfo | grep 'model name' | cut -d':' -f2 | cut -d' ' -f2- | head -1)"
  local this_cpu_speed="$(cat /proc/cpuinfo | grep -i 'cpu mhz' | cut -d':' -f2 | cut -d' ' -f2 | head -1)"
  local this_cpu_speed="$(echo "scale=2; ${this_cpu_speed}/1024" | bc) GHz"  # round up by second float
  local this_cpu_count="$(cat /proc/cpuinfo | grep 'model name' | wc -l)"

  if [[ "${this_cpu_info}" = "simple" ]]; then
    echo "${this_cpu_speed} x${this_cpu_count}"
  else
    echo "${this_cpu_name} (${this_cpu_speed} x${this_cpu_count})"
  fi
}
