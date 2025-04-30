#!/bin/bash
set -e
state_string='1234567890'
pintString() {
   local num=$1
   state_string="$state_string$num"
   echo $state_string
   sleep "$(bc <<< "$3 * 0.1")" 
}



if [[ -z "$TEST_COUNTER" ]]; then
   echo "error! set TEST_COUNTER"
   exit 1
elif [[ "$TEST_COUNTER" -eq 0 ]]; then
 i=0 
 
  while true; do
    i=$((i + 1))  
    pintString $i $state_string 1
  done 
else
   for ((i = 1; i <= $TEST_COUNTER; i++)); do
       pintString $i $state_string $TEST_COUNTER
   done
fi