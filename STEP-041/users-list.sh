#!/bin/bash
set -e

cat /etc/passwd | awk -F: '{print $1}' | sort 