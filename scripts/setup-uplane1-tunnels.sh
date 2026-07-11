#!/usr/bin/env bash
set -e

# Enable IPv4 forwarding
sudo sed -i 's/^#\?net.ipv4.ip_forward=.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sudo sysctl -p

# Configure DN internet: 10.45.0.0/16 -> ogstun
sudo ip tuntap add name ogstun mode tun || true
sudo ip addr add 10.45.0.1/16 dev ogstun || true
sudo ip link set ogstun up
sudo iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o ogstun -j MASQUERADE

# Configure DN internet2: 10.46.0.0/16 -> ogstun2
sudo ip tuntap add name ogstun2 mode tun || true
sudo ip addr add 10.46.0.1/16 dev ogstun2 || true
sudo ip link set ogstun2 up
sudo iptables -t nat -A POSTROUTING -s 10.46.0.0/16 ! -o ogstun2 -j MASQUERADE
