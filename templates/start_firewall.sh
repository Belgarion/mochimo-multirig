#!/bin/bash

# Mochimo multirig firewall rules
NETDEV=$(ip route get 8.8.8.8 | sed -n 's/.*dev \([A-Za-z0-9-]*\).*/\1/p')
echo "Starting firewall"
echo "Internet interfaec: $NETDEV"

iptables -n -t nat -L mochimo-post >/dev/null || iptables -t nat -N mochimo-post
iptables -t nat -F mochimo-post
iptables -t nat -C POSTROUTING -j mochimo-post 2>/dev/null || iptables -t nat -I POSTROUTING -j mochimo-post
iptables -t filter -C FORWARD -s 10.200.{{ rig_id }}.0/24 -j ACCEPT 2>/dev/null || iptables -t filter -I FORWARD -s 10.200.{{ rig_id }}.0/24 -j ACCEPT
iptables -t filter -C FORWARD -d 10.200.{{ rig_id }}.0/24 -j ACCEPT 2>/dev/null || iptables -t filter -I FORWARD -d 10.200.{{ rig_id }}.0/24 -j ACCEPT
#Groups[mochimo]
{% for host in groups['mochimo'] %}
iptables -t nat -A mochimo-post -s 10.200.{{ rig_id }}.0/24 -d 10.200.{{ hostvars[host]['rig_id'] }}.0/24 -j ACCEPT
{% endfor %}
iptables -t nat -A mochimo-post -s 10.200.{{ rig_id }}.0/24 -o $NETDEV -j MASQUERADE
