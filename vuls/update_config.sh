#!/bin/bash 

#for line in $(cat /etc/hosts |grep 192|xargs) 
cat /etc/hosts |grep 192| while read line
do
        ip=$(echo $line | awk '{print $1}')
        srv=$(echo $line | awk '{print $2}')
#	echo $ip
#        echo $srv
	line1="[servers.$(echo $srv)]"
	line2="host         = \"$(echo $ip)\""
	line3="port        = \"22\""
	line4="user        = \"saua\""
	line5="keyPath     = \"/home/saua/.ssh/id_rsa\""
        echo $line1
        echo $line2
        echo $line3
        echo $line4
        echo $line5
done
