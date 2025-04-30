#!/bin/sh

local_dir='/home/lis/5.5.study/4_factory/github_factory'
remote_dir='/home/sdogg/synced'
username='bmarley'  
server_ip='206.189.15.65'
port='222'
identity_file='~/.ssh/factory'
rsync --rsync-path="sudo rsync" -avz -e "ssh -p $port -i $identity_file" $local_dir "$username@$server_ip:$remote_dir"