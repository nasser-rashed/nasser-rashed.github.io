#!/bin/bash

cat /etc/hosts | grep 192 |awk '{print $1}' | while read line
do
	/usr/bin/ssh-keyscan -p 22 $line >> ~/.ssh/known_hosts
done 
