#!/bin/bash

# Delete default gateway
sudo ip route del 0/0

# Add new default gateway
sudo ip route add 0.0.0.0/0 via $1

# Add nameserver
echo "nameserver $2" > /etc/resolv.conf

# Show some info
OUTPUT=$(ip -c -brief a)
echo -e "\nIP configuration:\n${OUTPUT}"

OUTPUT=$(ip -c route)
echo -e "\nRoutes:\n${OUTPUT}"


