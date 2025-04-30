#!/bin/bash

set -e

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

for i in {1..10}; do
  sudo useradd -m "testacc$i"
  mkdir -p "/home/testacc$i/.ssh/"
  chmod 700 "/home/testacc$i/.ssh/"

  ssh-keygen -q -t rsa -N '' -f /home/testacc$i/.ssh/id_rsa  <<< y  >/dev/null 2>&1
 
  chown "testacc$i":"testacc$i" -R /home/testacc$i/.ssh/  
  touch "/home/testacc$i/.ssh/authorized_keys"
  chmod 600 "/home/testacc$i/.ssh/authorized_keys"

  if [[ $i -ne 10 ]]; then
    cat /home/testacc1/.ssh/id_rsa.pub >> /home/testacc$i/.ssh/authorized_keys  
  fi
  
done
        
cat /home/testacc1/.ssh/id_rsa.pub >> /home/testacc10/.ssh/authorized_keys        
