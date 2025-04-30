#!/bin/bash

set -e


err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

genRandomName() {
  chars='abcdefghijklmnopqrstuvwxyz'
  
  str=
  for ((i = 0; i < $1; ++i)); do
      str+=${chars:RANDOM%${#chars}:1}
  done
  
  echo "$str"
}

getMod() {
  declare -n arr=$1  

  current="${arr[0]}"
  lines2=("${arr[@]:1}")  
  lines2+=("$current")      

  arr=("${lines2[@]}")    
}

folderLines=("006" "600" "060")
fileLines=("777" "400" "600" "700" "740" "760" "770" "774" "776")
dirCount=$(awk -F'|' '{print $1}' /tmp/parameters)
fileCount=$(awk -F'|' '{print $2}' /tmp/parameters)


if [[ ! -e "/tmp/parameters" ]]; then
  err "There is no file here"
fi



echo $dirCount $fileCount

for ((i = 0; i <= $dirCount; i++)); do
  getMod folderLines
 
  mod="${folderLines[0]}"
  
  echo "current mod: " $mod

  nameLength=$((i + 5))
  name=$(genRandomName $nameLength)
   
  mkdir -p /tmp/test/$name
  chmod "$mod" /tmp/test/$name
done


for ((i = 0; i <= $fileCount; i++)); do
  getMod fileLines
 
  mod="${fileLines[0]}"
  
  echo "current mod: " $mod

  nameLength=$((i + 5))
  name=$(genRandomName $nameLength)
  echo "$name" 
  touch /tmp/test/$name
  chmod "$mod" /tmp/test/$name
done

ls -l /tmp/test/ | grep -v ^d
ls -l /tmp/test/ | grep ^d
