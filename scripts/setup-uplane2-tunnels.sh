#!/usr/bin/env bash
set -e

# Enable IPv4 forwarding
sudo sed -i 's/^#\?net.ipv4.ip_forward=.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sudo sysctl -p

# Configure DN ims: 10.47.0.0/16 -> ogstun3
sudo ip tuntap add name ogstun3 mode tun || true
sudo ip addr add 10.47.0.1/16 dev ogstun3 || true
sudo ip link set ogstun3 up
sudo iptables -t nat -A POSTROUTING -s 10.47.0.0/16 ! -o ogstun3 -j MASQUERADE
