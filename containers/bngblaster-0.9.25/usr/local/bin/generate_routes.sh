#!/usr/bin/env bash
set -euo pipefail

declare -r ROUTER=$1

declare -r RX1_IP=$2
declare -r RX1_IP6=$3

declare -r RX2_IP=$4
declare -r RX2_IP6=$5

# IPv4 updates for RX1
bgpupdate -f "/tmp/${ROUTER}_ipv4_rx1.bgp" --local-pref 100 -n "${RX1_IP}" -N 1 -p 198.18.0.0/31 -P 900000 --end-of-rib \
    -s "${ROUTER}_ipv4_streams.json" \
    --stream-direction downstream \
    --stream-pps 1 \
    --stream-interface "${ROUTER}"
bgpupdate -f "/tmp/${ROUTER}_ipv4_rx1-withdraw.bgp" --local-pref 100 -n "${RX1_IP}" -N 1 -p 198.18.0.0/31 -P 900000 --withdraw --end-of-rib


# IPv6 updates for RX1
bgpupdate -f "/tmp/${ROUTER}_ipv6_rx1.bgp" --local-pref 100 -n "${RX1_IP6}" -N 1 -p 2001:db8:ffff::/76 -P 900000 --end-of-rib \
    -s "${ROUTER}_ipv6_streams.json" \
    --stream-direction downstream \
    --stream-pps 1 \
    --stream-interface "${ROUTER}"
bgpupdate -f "/tmp/${ROUTER}_ipv6_rx1-withdraw.bgp" --local-pref 100 -n "${RX1_IP6}" -N 1 -p 2001:db8:ffff::/76 -P 900000 --withdraw --end-of-rib


# IPv4 updates for RX2
bgpupdate -f "/tmp/${ROUTER}_ipv4_rx2.bgp" --local-pref 10 -n "${RX2_IP}" -N 1 -p 198.18.0.0/31 -P 900000 --end-of-rib
bgpupdate -f "/tmp/${ROUTER}_ipv4_rx2-withdraw.bgp" --local-pref 10 -n "${RX2_IP}" -N 1 -p 198.18.0.0/31 -P 900000 --withdraw --end-of-rib

# IPv6 updates for RX2
bgpupdate -f "/tmp/${ROUTER}_ipv6_rx2.bgp" --local-pref 10 -n "${RX2_IP6}" -N 1 -p 2001:db8:ffff::/76 -P 900000 --end-of-rib
bgpupdate -f "/tmp/${ROUTER}_ipv6_rx2-withdraw.bgp" --local-pref 10 -n "${RX2_IP6}" -N 1 -p 2001:db8:ffff::/76 -P 900000 --withdraw --end-of-rib
