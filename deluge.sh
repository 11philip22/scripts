#!/bin/bash

sudo su
adduser deluge --shell /dev/null --disabled-password --disabled-login
add-apt-repository ppa:deluge-team/ppa \
&& apt update \
&& apt install -y deluged deluge-web \
&& gpasswd -a $USER deluge

cat > /etc/systemd/system/deluged.service << \EOF
[Unit]
Description=Deluge Bittorrent Client Daemon
After=network-online.target
[Service]
Type=simple
User=deluge
Group=deluge
UMask=002
ExecStart=/usr/bin/deluged -d
Restart=on-failure
# Configures the time to wait before service is stopped forcefully.
TimeoutStopSec=300
[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/deluge-web.service << \EOF
[Unit]
Description=Deluge Bittorrent Client Web Interface
After=network-online.target
[Service]
Type=simple
User=deluge
Group=deluge
UMask=002
ExecStart=/usr/bin/deluge-web
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

systemctl --system daemon-reload \
&& systemctl enable deluged \
&& systemctl start deluged \
&& systemctl status deluged \
&& systemctl enable deluge-web \
&& systemctl start deluge-web \
&& systemctl status deluge-web
reboot
