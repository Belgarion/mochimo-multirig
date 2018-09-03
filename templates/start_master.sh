#!/bin/sh
{% if has_public != "true" %}
# This node does not have a public ip.
# Wait for public nodes to be reachable
{% for host in groups['mochimo'] %}
{% if hostvars[host]['has_public'] == "true" %}
echo "Waiting for master ({{host}}) to start listening"
/opt/mochimo/wait_for_ip.sh {{host}} 2095
if [[ $? -ne 0 ]]; then
	echo "Timed out waiting for {{host}}, aborting."
	exit 1
fi
{% endif %}
{% endfor %}
{% endif %}
if tmux has-session -t=mochi-master; then
	echo "Master already running, keeping it."
else
	echo "Starting master"
	tmux -2 new-session -d -s mochi-master "./gomochi d -s25"
fi
