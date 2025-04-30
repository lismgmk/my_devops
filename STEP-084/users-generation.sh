#!/bin/bash

set -e

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

if [[ -z $1 ]]; then
  err "empty arg"
  exit 1
fi

package=$1
version=

versions="$(apt-cache madison $package | awk '{print $3}')"

if [[ -z "$versions" ]]; then
  err "versions was not been founded"
  exit 1
fi

echo -n "${versions} chose installation version => "
read version

if [[ -z "$version" ]]; then
  err "empty version"
  exit 1
fi

apt install --allow-downgrades -y $package=$version

installed_version="$(dpkg -s $package | grep Version | awk '{print $2}')"
if [[ $version != $installed_version ]]; then
  err "wrong installed version"
  exit 1
else
  echo "$installed_version - installed version of ${package}"
  exit 0  
fi