#!/bin/sh
ip=$1
port=$2
count=0
while true; do
	nc.openbsd -z $ip $port && break
	sleep 6
	count=$[count+1]
	if [[ $count -gt 200 ]]; then
		echo "There has now been 1200 seconds and master hasn't completed sync, aborting."
		exit 1
	fi
done
