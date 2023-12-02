pinga=$(ping -q -w1 $1 >> /dev/null && echo $?) 2>>/dev/null
