#!/bin/bash

set -e

core=1
duration="10"

sudo stress-ng --cpu "$core" -v --timeout "${duration}s" &

sleep 2

top | head -n 15

vmstat 1 $duration 
