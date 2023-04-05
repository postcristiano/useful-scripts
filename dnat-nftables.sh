#!/bin/bash

ip route add 172.16.3.160 via 172.16.10.245 dev ens19

nft flush ruleset
nft add table ip nat
nft -- add chain ip nat prerouting { type nat hook prerouting priority -100\; }
nft add chain ip nat postrouting { type nat hook postrouting priority 100\; }
nft add rule ip nat prerouting tcp dport { 443, 9443, 17040, 8080, 4001, 3000, 5562, 8500 } dnat to 172.16.3.160
nft add rule ip nat postrouting ip daddr 172.16.3.160 masquerade