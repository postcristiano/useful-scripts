#!/bin/bash

# add out route to next hop
ip route add 172.16.3.160 via 172.16.10.245 dev ens19

# clear previous rules
nft flush ruleset

# add nft table and chains
nft add table ip nat
nft -- add chain ip nat prerouting { type nat hook prerouting priority -100\; }
nft add chain ip nat postrouting { type nat hook postrouting priority 100\; }
nft add rule ip nat prerouting tcp dport { 443, 9443, 17040, 8080, 4001, 3000, 5562, 8500 } dnat to 172.16.3.160

# outgoing address masquerading
nft add rule ip nat postrouting ip daddr 172.16.3.160 masquerade


"""
#!/bin/bash

# Get a list of available network interfaces
interfaces=$(ifconfig -a | grep '^[a-zA-Z]' | awk '{print $1}')

# Prompt the user to select an interface
echo "Available network interfaces:"
echo "$interfaces"
read -p "Enter the name of the interface you want to select: " selected_interface

# Store the selected interface in a variable
if [[ "$interfaces" == *"$selected_interface"* ]]; then
  echo "You selected $selected_interface"
else
  echo "Invalid selection. $selected_interface is not a valid network interface."
  exit 1
fi
"""
