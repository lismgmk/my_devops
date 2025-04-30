#!/bin/bash

set -e

temp=$(getopt -o "" --long login:,limit: -- "$@")
eval set -- "$temp"
          
user=
limit=10

while true; do
  case "$1" in
    --login) 
      if [[ -n "$2" && "$2" != "--" ]]; then
            user="$2"
            shift 2
        else
          if ! grep -q "^$user:" /etc/passwd; then
            err "There is no login"
            exit 1
          fi
      fi
      ;;
    --limit) 
        if [[ -n "$2" && "$2" != "--" ]]; then
          if ! [[ "$limit" =~ ^[0-9]+$ ]]; then
            err "Limit must be a valid number"
            exit 1
          fi  
          limit="$2"
          shift 2
        fi
        ;;
    --) shift; break ;;
    *) break ;;
  esac
done


zgrep -E "sudo.*$user :" /var/log/auth.log* | tail -n "$limit"
exit 0

