#!/bin/sh
/opt/mochimo/setup_networking.sh 10.200.{{rig_id}}.1/24

echo "Waiting for master to start listening"
/opt/mochimo/wait_for_ip.sh 10.200.{{rig_id}}.1 2095
if [ $? -ne 0 ]; then
	echo "Timed out waiting for 10.200.{{rig_id}}.1, aborting."
	exit 1
fi

{% for i in range(num_gpus-1) %}
./run_netns.sh c{{ rig_id }}{{ i+1 }} 10.200.{{ rig_id }}.{{ i+10 }} 10.200.{{rig_id}}.1 {{ i+1 }}
{% endfor %}
