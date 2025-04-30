#!/bin/bash

set -e

cp /etc/passwd /tmp/passwd

for user in  $(awk -F: '!/root/ {print $1}' /etc/passwd);do
  sudo usermod -s /usr/sbin/nologin "$user"
done