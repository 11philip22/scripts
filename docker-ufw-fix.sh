#!/bin/bash

echo "{\"iptables\": false}" > /etc/docker/daemon.json
sed -i -e 's/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw
ufw reload
iptables -t nat -A POSTROUTING ! -o docker0 -s 172.17.0.0/16 -j MASQUERADE
systemctl restart docker
