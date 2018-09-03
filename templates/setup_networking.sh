#!/bin/sh
IPCIDR="$1"

# Enable forwarding
sysctl -q net.ipv4.conf.all.forwarding=1

if ! brctl show | grep -q "^br-ns\\s"; then
	# bridge does not exist, create it
	brctl addbr br-ns
fi

if ! ip addr show br-ns | grep -q "inet ${IPCIDR}"; then
	# ip does not exist on bridge, add it
	ip addr add $IPCIDR dev br-ns
fi
