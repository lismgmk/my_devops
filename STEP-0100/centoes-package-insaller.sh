#!/bin/bash

set -e

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

if [[ $# -lt 2 ]]; then 
  err "wrong args amount"
  exit 1
fi

if [[ ${@: -1} != "install" && ${@: -1} != "uninstall" ]]; then
  err "wrong last arg"
  exit 1
fi

cmd="${@: -1}"
packages=("${@:1:$#-1}")


if [[ ${@: -1} == "install" ]]; then
  for el in "${packages[@]}"; do
    dnf -y install $el  &> /dev/null
	  echo "package $el has been installed"
  done
fi

if [[ ${@: -1} == "uninstall" ]]; then
  for el in "${packages[@]}"; do
    dnf -y remove $el  &> /dev/null
	  echo "package $el has been deleted"
  done
fi