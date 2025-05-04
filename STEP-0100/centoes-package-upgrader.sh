#!/bin/bash

set -e

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

if [[ $# -lt 2 ]]; then 
  err "wrong args amount"
  exit 1
fi

package=$1
version=$2

dnf install -y "${package}-${version}"
