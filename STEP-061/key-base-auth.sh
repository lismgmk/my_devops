#!/bin/bash

set -e

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

if [[ $# -lt 3 ]];then 
  err "wrong args amount+"
  exit 1
fi

name=$(echo "$1" | awk '{print tolower($0)}')
firstChar=${name:0:1}

lastName=$(echo "$2" | awk '{print tolower($0)}')
group=$(echo "$3" | awk '{print tolower($0)}')
filePath="$4"

user="$firstChar$lastName"
useradd -m $user
usermod -a -G $group $user


cat /etc/passwd | grep -w $user | awk -F':' '{print "Login: " $1 "\nShell: " $7 "\nHome dir: " $6}' 
groups $user | awk -F':' '{print "Groups: " $2}'
echo "UID: " $(id -u $user)



if [[ ! -d "/home/$user/.ssh/" ]]; then
  mkdir -p "/home/$user/.ssh/"
  chmod 700 "/home/$user/.ssh/"
  chown $user:$user "/home/$user/.ssh/"  
fi


cat "$filePath" >> "/home/$user/.ssh/authorized_keys"
chown $user:$user "/home/$user/.ssh/authorized_keys"

chmod 600 "/home/$user/.ssh/authorized_keys"