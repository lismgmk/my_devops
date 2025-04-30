#!/bin/bash

set -e

swapoff -a
for ((i = 0 ; i < 35 ; i++)); do
  stress-ng --vm 1 --vm-bytes 25% -t 30s &> /dev/null &
  sleep 0.5
  free -h
done

echo "Checking OOM-Killer logs..."
dmesg | grep -i 'oom'  | grep -i 'stress-ng-vm'
echo "Current state"
free -h

