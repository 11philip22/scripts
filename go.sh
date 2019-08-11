#!/bin/sh

WLANINTERFACE=wlxe894f6096f68
WANINTERFACE=wlp2s0
WLANIP=192.168.234.254
DNSMASQPIDFILE="/var/run/dnsmasq-${WLANINTERFACE}.pid"

sudo ip link set up dev ${WLANINTERFACE}
sudo ip addr add ${WLANIP}/24 dev ${WLANINTERFACE}
sudo sysctl -w net.ipv4.conf.all.forwarding=1

sudo iptables -t nat -A PREROUTING -i ${WLANINTERFACE} -p tcp --dport 80 -j DNAT --to-destination ${WLANIP}:8080
sudo iptables -t nat -A PREROUTING -i ${WLANINTERFACE} -p tcp --dport 443 -j DNAT --to-destination ${WLANIP}:8080
sudo iptables -t nat -I POSTROUTING -o ${WANINTERFACE} -j MASQUERADE
sudo iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i ${WLANINTERFACE} -o ${WANINTERFACE} -j ACCEPT

sudo dnsmasq -x "${DNSMASQPIDFILE}" -k -d -z -i ${WLANINTERFACE} -F 192.168.234.10,192.168.234.250,8h &
sudo ./hostap/hostapd/hostapd -d -i ${WLANINTERFACE} hostapd.conf &

read -r input
echo "Exiting...."

## Kill everything...
sudo killall hostapd
# sudo pkill -F "${DNSMASQPIDFILE}"
sudo killall dnsmasq
sudo ip addr flush dev ${WLANINTERFACE}
sudo ip link set down dev ${WLANINTERFACE}
sudo iptables -t nat -D PREROUTING -i ${WLANINTERFACE} -p tcp --dport 80 -j DNAT --to-destination ${WLANIP}:8080
sudo iptables -t nat -D PREROUTING -i ${WLANINTERFACE} -p tcp --dport 443 -j DNAT --to-destination ${WLANIP}:8080
sudo iptables -t nat -I POSTROUTING -o ${WANINTERFACE} -j MASQUERADE
sudo iptables -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -D FORWARD -i ${WLANINTERFACE} -o ${WANINTERFACE} -j ACCEPT

