#!/usr/bin/env bash
set -euo pipefail
mkdir -p /opt/bngblaster/
# IPv4 updates
bgpupdate -a 4200000255 -l 100 -n 192.0.2.31 -p 198.18.0.0/31 -P 100000 -f /opt/bngblaster/bird-3.1.4.bgp
bgpupdate -a 4200000255 -l 100 -n 192.0.2.31 -p 22.0.0.0/30 -P 100000 -f /opt/bngblaster/bird-3.1.4.bgp --append
bgpupdate -a 4200000255 -n 192.0.2.31 -p 22.0.0.0/30 -P 100000 -f /opt/bngblaster/bird-3.1.4.bgp --withdraw --append
# IPv6 updates
bgpupdate -a 4200000255 -l 100 -n 2001:db8:100::31 -p 2001:db8:ffff::/73 -P 100000 -f /opt/bngblaster/bird-3.1.4.bgp --append
bgpupdate -a 4200000255 -l 100 -n 2001:db8:100::31 -p 2001:db8:eeee::/73 -P 100000 -f /opt/bngblaster/bird-3.1.4.bgp --append
bgpupdate -a 4200000255 -n 2001:db8:100::31 -p 2001:db8:eeee::/73 -P 100000 -f /opt/bngblaster/bird-3.1.4.bgp --withdraw --append
