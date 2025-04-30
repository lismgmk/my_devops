#!/bin/bash

set -e

mkfs.ext4 /dev/sda
mkdir -p /mnt
mount /dev/sda /mnt
