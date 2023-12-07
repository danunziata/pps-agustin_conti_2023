#!/bin/bash

#  List insterfaces
echo "IP Addresses:" >>/etc/issue
for iface in $(ip -br link | awk '!/lo/ { print $1}'); do
  echo "$iface - \\4{$iface}" >>/etc/issue
done
