#!/bin/bash
set -e
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

lines=${2:-10}

if [[ $1 == "logged_users" ]]; then
  cat <<- EndOfMessage
Logged users:
-------------
$(w) 
Logged users count: $(w -h | wc -l)
EndOfMessage
  
elif [[ $1 == "auth_history" ]]; then
  echo "history";
  last | head -n "$lines"
else
  err "wrong agr"
  exit 1  
fi  