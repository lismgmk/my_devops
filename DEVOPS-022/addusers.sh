#!/bin/bash

sshpubkey_user_path='root'


isHash() {
    if [[ $1 =~ ^\$|^[0-9]|[0-9]$|==$ ]]; then
        return 0 
    else
        return 1 
    fi
}

echo $#

if [[ $# == 0 ]];then 
        echo "wrong args amount+"
        exit 1
fi

case $# in
   0)
        echo "wrong args amount"
        exit 1
   ;;     
   1)
        if isHash $1; then
                echo "wrong login"
                exit 1           
        else 
                login=$1
                echo "login $login"
        fi
   ;; 
   2)
      if  isHash $2; then
                login=$1
                hash_pass=$2
                echo "login $login hash_pass $hash_pass"
      elif isHash $1; then
                echo "wrong login"
                exit 1
      else
                name=$1
                surname=$2
                echo "name $name surname $surname"
      fi
    ;;
    3|4)
        if isHash $1; then
                hash_pass=$1
                name=$2
                surname=$3
                 echo "hash_pass $hash_pass name $name surname $surname"
        elif isHash $2; then
                login=$1
                hash_pass=$2
                echo "login $login hash_pass $hash_pass"
        elif isHash $3; then
                echo "wrong args"
                exit 1
        else
                login=$1
                echo "login $login"
        fi
        
     ;;
     
  *)
    echo "wrong count of args"
    exit 1
    ;;
esac

if [[ -z $login ]]; then
        login="${name:0:1}${surname,,}"
fi

user="${login,,}"
echo "user:  $user"

if [[ -z $hash_pass ]]; then
        hash_pass=$(openssl passwd -6)
        echo "You hash is: $hash_pass"
fi

useradd -m -p $hash_pass  $user 
echo "Code: $?"


if [[ -z $SSHPUBKEY ]]; then
   SSHPUBKEY=$(cat /${sshpubkey_user_path}/.ssh/factory.pub)
fi

mkdir -p /home/$user/.ssh
echo "$SSHPUBKEY" >> /home/$user/.ssh/authorized_keys
chmod 600 /home/$user/.ssh/authorized_keys
chown $user:$user /home/$user/.ssh/authorized_keys

if [[ $user == 'bmarley' ]]; then
    cp /etc/sudoers /etc/sudoers.bak
    echo -e "$USER ALL=(ALL) NOPASSWD: /usr/bin/rsync\n$user ALL=(ALL) /usr/sbin/reboot" >> /etc/sudoers
    echo "bmarley $?"
fi
