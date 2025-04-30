#!/bin/bash

set -e

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

if [[ -z $1 ]];then
  err "empty agr"
  exit 1  
fi

mapfile -t folders_arr < <(du -h --max-depth=1 $1 | awk '{print $1 ":" $2}')
unset "folders_arr[-1]"

for file in "${folders_arr[@]}"; do
  size=$(echo "$file" | awk -F: '{print $1}')
  path=$(echo "$file" | awk -F: '{print $2}')
  file_count=$(find "$path" -type f | wc -l)	

  echo "$path files: $file_count size: $size" 
done

