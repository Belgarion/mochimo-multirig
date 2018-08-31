#!/bin/bash

echo "Adding routes"
{% for host in groups['mochimo'] %}
{% if hostvars[host]['rig_id'] != rig_id %}
ip route show | grep -q "10.200.{{ hostvars[host]['rig_id'] }}.0/24 via" && ip route delete 10.200.{{ hostvars[host]['rig_id'] }}.0/24
ip route add 10.200.{{ hostvars[host]['rig_id'] }}.0/24 via {{ host }}
{% endif %}
{% endfor %}
