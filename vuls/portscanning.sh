#! /bin/bash

args=$(echo $*)
#echo $args
argscount=$(echo $args|wc -l)
#echo $argscount
if [ $argscount -lt 1 ]; then
   echo "invalid arguments"
   echo "exiting ..."
   exit 89
fi

ip=$1
#echo $ip
status=$(timeout 10s curl -s $ip:22 > /dev/null)
status0=$(echo $?)
if [ $status0 -eq 56 ]; then
   # echo port 22 is open on hosts: $ip
   exit 0
else
   exit 70
fi
