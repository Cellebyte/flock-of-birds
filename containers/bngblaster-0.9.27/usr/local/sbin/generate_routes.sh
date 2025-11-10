#!/usr/bin/env bash
set -euo pipefail

declare -r ROUTER=$1

declare -r RX1_IP=$2
declare -r RX1_IP6=$3

declare -r RX2_IP=$4
declare -r RX2_IP6=$5

declare -r ROUTE_COUNT=90000

# IPv4 updates for RX1
bgpupdate -f "/tmp/${ROUTER}_ipv4_rx1.bgp" -a 4200000255 --med 10 -n "${RX1_IP}" -N 1 -p 198.18.0.0/31 -P "${ROUTE_COUNT}" --end-of-rib \
    -s "/tmp/${ROUTER}_ipv4_streams.json" \
    --stream-direction downstream \
    --stream-pps 1 \
    --stream-interface "${ROUTER}-rx1"
bgpupdate -f "/tmp/${ROUTER}_ipv4_rx1-withdraw.bgp" -a 4200000255 --med 10 -n "${RX1_IP}" -N 1 -p 198.18.0.0/31 -P "${ROUTE_COUNT}" --withdraw --end-of-rib


# IPv6 updates for RX1
bgpupdate -f "/tmp/${ROUTER}_ipv6_rx1.bgp" -a 4200000255 --med 10 -n "${RX1_IP6}" -N 1 -p 2001:db8:ffff::/76 -P "${ROUTE_COUNT}" --end-of-rib \
    -s "/tmp/${ROUTER}_ipv6_streams.json" \
    --stream-direction downstream \
    --stream-pps 1 \
    --stream-interface "${ROUTER}-rx1"
bgpupdate -f "/tmp/${ROUTER}_ipv6_rx1-withdraw.bgp" -a 4200000255 --med 10 -n "${RX1_IP6}" -N 1 -p 2001:db8:ffff::/76 -P "${ROUTE_COUNT}" --withdraw --end-of-rib


# IPv4 updates for RX2
bgpupdate -f "/tmp/${ROUTER}_ipv4_rx2.bgp" -a 4200000255 --med 100 -n "${RX2_IP}" -N 1 -p 198.18.0.0/31 -P "${ROUTE_COUNT}" --end-of-rib
bgpupdate -f "/tmp/${ROUTER}_ipv4_rx2-withdraw.bgp" -a 4200000255 --med 100 -n "${RX2_IP}" -N 1 -p 198.18.0.0/31 -P "${ROUTE_COUNT}" --withdraw --end-of-rib

# IPv6 updates for RX2
bgpupdate -f "/tmp/${ROUTER}_ipv6_rx2.bgp" -a 4200000255 --med 100 -n "${RX2_IP6}" -N 1 -p 2001:db8:ffff::/76 -P "${ROUTE_COUNT}" --end-of-rib
bgpupdate -f "/tmp/${ROUTER}_ipv6_rx2-withdraw.bgp" -a 4200000255 --med 100 -n "${RX2_IP6}" -N 1 -p 2001:db8:ffff::/76 -P "${ROUTE_COUNT}" --withdraw --end-of-rib

echo "convergence.py --host localhost --router ${ROUTER} --rx1-ip ${RX1_IP} --rx1-ip6 ${RX1_IP6} --rx2-ip ${RX2_IP} --rx2-ip6 ${RX2_IP6}"