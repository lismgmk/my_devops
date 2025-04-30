#!/bin/bash

set -e

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

if [[ $# -lt 2 ]];then 
  err "wrong args amount"
  exit 1
fi

if [[ "$1" =~ ^[0-9]+$ ]]; then
 
  if [[ $2 == "kill" ]];then
    kill -SIGTERM "$1"
    exit 0
  elif [[ $2 == "forcekill" ]];then
    kill -SIGTERM "$1"
    sleep 10
    if ps -p "$1" > /dev/null; then
      kill -SIGKILL "$1"
    fi
    exit 0
  else 
    err "wrong seconds arg"
    exit 1
  fi

else
 
  if [[ $2 == "kill" ]];then
    pkill -SIGTERM "$1"
    exit 0
  elif [[ $2 == "forcekill" ]];then
    pkill -SIGTERM "$1"
    sleep 10
    if pgrep "$1" > /dev/null; then
      pkill -SIGKILL "$1"
    fi
    exit 0
  else 
    err "wrong seconds arg"
    exit 1
  fi
fi


