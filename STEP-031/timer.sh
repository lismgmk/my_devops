#!/bin/bash
set -e
echo "UTC time: $(LC_TIME=en_US.UTF-8 date --utc)" 
 
echo "NY time: $(TZ='America/New_York' date)"

echo "Tokyo time: $(TZ='Asia/Tokyo' date)"

next_day=$(LC_TIME=en_US.UTF-8 date --date='1 day' +%A)
smile=""

if [[ $next_day == "Saturday" || $next_day == "Sunday" ]];then 
  smile=$'\U1F600'  
fi

echo "Tomorrow: $next_day $smile"