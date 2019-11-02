#!/usr/bin/env bash

# sample:
## displaying variable content, line by line
#for plugin in $plugins_list; do
#    echo $plugin
#done


#-----------------------

function get_cpu_model(){
  local this_cpu_name="$(cat /proc/cpuinfo |grep -Eo 'CPU[[:print:]]+@ [[:digit:]|.]+GHz')"
  echo "${this_cpu_name}"
}
