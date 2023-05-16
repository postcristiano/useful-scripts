#!/usr/bin/env sh
#
# https://github.com/postcristiano/useful-scripts
#
# Copyright (c) 2023 postCristiano. Released under the BSD License 2.0

if [ "$EUID" -ne 0 ] 2> /dev/null > /dev/null; then
    echo "Run as a root"
    exit
fi

if [ -f "/usr/local/bin/openvpn_traffic.sh" ]; then
    echo "This script is already installed."
    # Add feature to uninstall script
    exit
fi

if dpkg -s openvpn &> /dev/null; then
    echo "This script is only useful if you have OpenVPN installed"
    exit
fi

nft_installed=0
iptables_installed=0

# Check if nftables package is installed
if dpkg -s nftables &> /dev/null; then
    nft_installed=1
fi

# Check if iptables package is installed
if dpkg -s iptables &> /dev/null; then
    iptables_installed=1
fi

# Check the installation status
if [ $iptables_installed -eq 1 ]; then
    echo "#!/bin/bash

# Function to allow network traffic
allow_traffic() {
    iptables -F
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -P FORWARD ACCEPT
}

# Function to block network traffic
block_traffic() {
    iptables -F
    iptables -P INPUT DROP
    iptables -P OUTPUT DROP
    iptables -P FORWARD DROP
}

# Check if OpenVPN is running
if pgrep -x "openvpn" > /dev/null; then
    allow_traffic
else
    block_traffic
fi" > /usr/local/bin/openvpn_traffic.sh
elif [ $nft_installed -eq 1 ]; then
    echo "#!/bin/bash

# Function to allow network traffic
allow_traffic() {
    nft flush ruleset
    nft add table inet filter
    nft add chain inet filter input { type filter hook input priority 0 \; }
    nft add chain inet filter output { type filter hook output priority 0 \; }
    nft add chain inet filter forward { type filter hook forward priority 0 \; }
    nft add rule inet filter input ct state established,related counter accept
    nft add rule inet filter output ct state established,related counter accept
    nft add rule inet filter forward ct state established,related counter accept
    nft add rule inet filter input iifname "lo" counter accept
    nft add rule inet filter output oifname "lo" counter accept
    nft add rule inet filter input iifname "tun+" counter accept
    nft add rule inet filter output oifname "tun+" counter accept
    nft add rule inet filter input counter drop
    nft add rule inet filter output counter drop
    nft add rule inet filter forward counter drop
}

# Function to block network traffic
block_traffic() {
    nft flush ruleset
    nft add table inet filter
    nft add chain inet filter input { type filter hook input priority 0 \; }
    nft add chain inet filter output { type filter hook output priority 0 \; }
    nft add chain inet filter forward { type filter hook forward priority 0 \; }
    nft add rule inet filter input ct state established,related counter accept
    nft add rule inet filter output ct state established,related counter accept
    nft add rule inet filter forward ct state established,related counter accept
    nft add rule inet filter input iifname "lo" counter accept
    nft add rule inet filter output oifname "lo" counter accept
    nft add rule inet filter input counter drop
    nft add rule inet filter output counter drop
    nft add rule inet filter forward counter drop
}

# Check if OpenVPN is running
if pgrep -x "openvpn" > /dev/null; then
    allow_traffic
else
    block_traffic
fi" > /usr/local/bin/openvpn_traffic.sh
else
    echo "Sorry, neither nftables nor iptables is installed."
    exit
fi


echo "[Unit]
Description=OpenVPN Traffic Control
After=network.target

[Service]
ExecStart=/usr/local/bin/openvpn_traffic.sh
Restart=always
RestartSec=3

[Install]
WantedBy=default.target" > /etc/systemd/system/openvpn-traffic.service

chmod +x /usr/local/bin/openvpn_traffic.sh
chmod 644 /etc/systemd/system/openvpn-traffic.service

systemctl start openvpn-traffic
systemctl enable openvpn-traffic