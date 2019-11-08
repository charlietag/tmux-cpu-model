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
  local this_cpu_name="$(cat /proc/cpuinfo | grep 'model name' | grep -Eo 'CPU[[:print:]]+@ [[:digit:]|.]+GHz' | head -1)"
  local this_cpu_count="$(cat /proc/cpuinfo | grep 'model name' | wc -l)"
  echo "${this_cpu_name} ▶▶▶ ${this_cpu_count}"
}
