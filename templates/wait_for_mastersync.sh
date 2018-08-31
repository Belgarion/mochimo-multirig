#!/bin/sh
count=0
while true; do
	netstat -ntlp | grep '2095.*LISTEN.*mochimo' -q && break
	sleep 5
	count=$[count+1]
	if [[ $count -gt 200 ]]; then
		echo "There has now been 1000 seconds and master hasn't completed sync, aborting."
		exit 1
	fi
done
