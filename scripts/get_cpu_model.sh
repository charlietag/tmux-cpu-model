#!/usr/bin/env bash

# sample:
## displaying variable content, line by line
#for plugin in $plugins_list; do
#    echo $plugin
#done


#-----------------------

function get_cpu_model(){
  local this_cpu_name="$(cat /proc/cpuinfo | grep 'model name' | grep -Eo 'CPU[[:print:]]+@ [[:digit:]|.]+GHz' | head -1)"
  local this_cpu_count="$(cat /proc/cpuinfo | grep 'model name' | wc -l)"
  echo "${this_cpu_name} ->${this_cpu_count"
}
