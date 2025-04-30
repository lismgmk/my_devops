#!/bin/bash

set -e

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

declare -A result

mapfile -t folders_arr < <(ps auxww | awk '$11 !~ /^\[/ {print $8 ":" $11}')

for file in "${folders_arr[@]}"; do
  key=$(awk -F: '{print $1}' <<< $file)
  value=$(awk -F: '{print $2}' <<< $file)
  result["$key"]+="$value "

done

for state in "${!result[@]}"; do
  count=$(echo "${result[$state]}" | wc -w)

  cat <<EOF
State: $state ($count processes)

--- 

${result[$state]}

EOF


done
