#!/usr/bin/env bash
set -e

# Run on VM5 (UE machine)
ping google.com -I uesimtun0 -n

# Run on VM2 (UPF1 machine) in another terminal
# tcpdump -i ogstun -n
