#!/bin/bash

set -e

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

temp=$(getopt -o '' --long login:,remove,no-password -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$temp"

user=
no_passwd=false
remove=false

while true; do
  case "$1" in
    --login ) user="$2"; shift 2;;
    --remove ) remove=true; shift ;;
    --no-password ) no_passwd=true; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [[ -z $user ]]; then
  err "There is no login"
  exit 1
fi

user_dir="/etc/sudoers.d/$user"


if [[ $remove == "true" ]]; then
  rm "$user_dir"  
  exit 0
fi

if [[ $no_passwd == "true" ]]; then
    echo "$user ALL=(ALL) NOPASSWD: ALL" > "$user_dir" 
    chmod 0440 "$user_dir"
  else
    echo "$user ALL=(ALL:ALL) ALL" > "$user_dir" 
    chmod 0440 "$user_dir"
fi
exit 0